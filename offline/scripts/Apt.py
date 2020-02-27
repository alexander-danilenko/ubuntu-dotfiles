from .Rainbow import *
import os
import subprocess
import apt

# Downloads deb files for list of packages with all their dependencies.
class AptDownload:
    # Directory to download deb files to.
    download_dir: str

    # Kernel version. Should be 'uname -r' compatible value.
    kernel: str

    # List of packages that needs to be downloaded.
    packages: [str]

    def __init__(self, packages, kernel='current', download_dir='./deb'):
        self.download_dir = download_dir
        self.setKernel(kernel)
        self.setPackages(packages)

    # Sets kernel version.
    def setKernel(self, kernel):
        self.kernel = kernel
        if self.kernel.lower() == 'current':
            k = subprocess.Popen('uname -r', stdout=subprocess.PIPE, shell=True)
            self.kernel = k.stdout.read().decode('utf-8').replace('\n', '')
        print_green(f'[apt] Using kernel "{self.kernel}"')
        return self

    # Sets packages list.
    def setPackages(self, packages):
        self.packages = packages
        for i in range(len(packages)):
            # Replace '{KERNEL}' with real kernel version.
            self.packages[i] = self.packages[i].replace('{KERNEL}', self.kernel)
        return self

    def getDownloadList(self):
        return sorted(AptDependencies(self.packages).dep_set)

    def runDownload(self):
        # Create download directory if not exists
        if not os.path.exists(self.download_dir):
            os.makedirs(self.download_dir)
        # Navigate to download directory
        os.chdir(self.download_dir)
        # Run 'apt download' in terminal.
        subprocess.run(f'apt download -q {" ".join(self.getDownloadList())}', shell=True)
        print_green(f'[apt] All packages was downloaded to "{self.download_dir}"')

# Calculates dependencies recursively for apt package list.
class AptDependencies:

    def __init__(self, pkg_list, recommends=False):
        self.dep_set = set()
        self.apt_cache = apt.cache.Cache()
        self.apt_cache.open()
        for item in pkg_list:
            p = self.apt_cache[item]
            self.deps_recurse(self.dep_set, p, recommends)
        self.apt_cache.close()

    def __call__(self, pkg_list, recommends=False):
        self.dep_set.clear()
        self.apt_cache.open()
        for item in pkg_list:
            p = self.apt_cache[item]
            self.deps_recurse(self.dep_set, p, recommends)
        self.apt_cache.close()

    def deps_recurse(self, s, p, recommends=False):
        deps = p.candidate.get_dependencies('Depends')
        pre_deps = p.candidate.get_dependencies('PreDepends')
        all_deps = deps + pre_deps
        if recommends:
            all_deps.extend(p.candidate.get_dependencies('Recommends'))
        for i in all_deps:
            dp = i.installed_target_versions
            if len(dp) > 0:
                if not dp[0].package.name in s:
                    s.add(dp[0].package.name)
                    self.deps_recurse(s, dp[0].package, recommends)
