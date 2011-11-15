Name:           example
Version:        0.2.11
Release:        1
License:        <insert license tag>
Summary:        <insert summary tag>
Url:            "http://"
Group:          <insert group tag>
Source0:        %{name}-%{version}.tar.gz
#BuildRequires:  pkgconfig(QtCore)
#BuildRequires:  libqt-devel
Requires:       qt

%description
# Add here description of the package.

%prep
%setup -q

%build
# Add here commands to configure the package.
#%qmake
#qmake -makefile -nocache QMAKE_STRIP=: PREFIX=%{_prefix}
/opt/make/qt-everywhere-opensource-src-4.8.0/bin/qmake example.pro -r -spec linux-g++-32

# Add here commands to compile the package.
#make %{?jobs:-j%jobs}
#make %{?_smp_mflags}
make

%install
# Add here commands to install the package.
#%qmake_install
make install INSTALL_ROOT=%{buildroot}

%files
%defattr(-,root,root,-)
%{_prefix}/*
/usr/lib/*
/opt/example/*
