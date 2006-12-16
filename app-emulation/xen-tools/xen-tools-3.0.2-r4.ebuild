# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/xen-tools/xen-tools-3.0.2-r4.ebuild,v 1.2 2006/12/16 04:38:32 aross Exp $

inherit mount-boot flag-o-matic distutils eutils multilib

DESCRIPTION="Xend daemon and tools"
HOMEPAGE="http://xen.sourceforge.net"
SRC_URI="http://www.cl.cam.ac.uk/Research/SRG/netos/xen/downloads/xen-${PV}-src.tgz"
S="${WORKDIR}/xen-${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc debug screen custom-cflags pygrub vnc sdl"

CDEPEND="dev-lang/python
	sys-libs/zlib
	sdl? ( media-libs/libsdl )
	vnc? ( media-libs/libsdl )
	pygrub? ( >=sys-fs/progsreiserfs-0.3.1_rc8 )"

DEPEND="${CDEPEND}
	sys-devel/gcc
	dev-lang/perl
	app-misc/pax-utils
	doc? (
		dev-tex/latex2html
		media-gfx/transfig
	)
	vnc? ( net-libs/libvncserver )"

RDEPEND="${CDEPEND}
	~app-emulation/xen-${PV}
	sys-apps/iproute2
	net-misc/bridge-utils
	screen? (
		app-misc/screen
		app-admin/logrotate
	)
	|| ( sys-fs/udev sys-apps/hotplug )"

PYTHON_MODNAME="xen grub"

pkg_setup() {
	if use vnc && ! use sdl ; then
		ewarn "You have the 'vnc' USE flag set, but not 'sdl'."
		ewarn "VNC functionality requires SDL support, so it"
		ewarn "will be enabled anyway."
	fi

	if [[ "$(scanelf -s __guard -q `which python`)" ]] ; then
		ewarn "xend may not work when python is built with stack smashing protection (ssp)."
		ewarn "If 'xm create' fails with '<ProtocolError for /RPC2: -1 >', see bug #141866"
	fi

	if [[ -z ${XEN_TARGET_ARCH} ]] ; then
		if use x86 ; then
			export XEN_TARGET_ARCH="x86_32"
		elif use amd64 ; then
			export XEN_TARGET_ARCH="x86_64"
		else
			die "Unsupported architecture!"
		fi
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# if the user *really* wants to use their own custom-cflags, let them
	if use custom-cflags; then
		einfo "User wants their own CFLAGS - removing defaults"
		# try and remove all the default custom-cflags
		find "${S}" -name Makefile -o -name Rules.mk -o -name Config.mk -exec sed \
			-e 's/CFLAGS\(.*\)=\(.*\)-O3\(.*\)/CFLAGS\1=\2\3/' \
			-e 's/CFLAGS\(.*\)=\(.*\)-march=i686\(.*\)/CFLAGS\1=\2\3/' \
			-e 's/CFLAGS\(.*\)=\(.*\)-fomit-frame-pointer\(.*\)/CFLAGS\1=\2\3/' \
			-e 's/CFLAGS\(.*\)=\(.*\)-g3*\s\(.*\)/CFLAGS\1=\2 \3/' \
			-e 's/CFLAGS\(.*\)=\(.*\)-O2\(.*\)/CFLAGS\1=\2\3/' \
			-i {} \;
	fi

	# xen tries to be smart and filter out CFLAGs not supported by gcc.
	# It doesn't handle no* flags though, but flag-o-matic's test-flag-CC does.
	for FLAG in -nopie -fno-stack-protector -fno-stack-protector-all; do
		test-flag-CC ${FLAG} && HARDFLAGS="${HARDFLAGS} ${FLAG}"
	done
	sed  -i "s/^CFLAGS :=$/& ${HARDFLAGS}/" \
		"${S}"/tools/firmware/{hvmloader,vmxassist}/Makefile


	# Disable the 32bit-only vmxassist if we are not on x86
	# and we don't support the x86 ABI
	if ! use x86 && ! has x86 $(get_all_abis); then
		sed -i -e "/SUBDIRS += vmxassist/d" "${S}"tools/firmware/Makefile
	fi

	if use pygrub; then
		# Upstream use Debian and hence progsreiserfs-0.3.0,
		# which has a different API to 0.3.1
		epatch "${FILESDIR}/${PVR}"/pygrub-progsreiserfs-0.3.1.patch
	else
		sed -i -e "/^SUBDIRS += pygrub$/d" "${S}"/tools/Makefile
	fi

	# Fixes for hardened and amd64
	epatch "${FILESDIR}"/${P}-bxclobber.patch
	epatch "${FILESDIR}"/${P}-pushpop.patch

	# Allow --as-needed LDFLAGS
	epatch "${FILESDIR}/${P}"--as-needed.patch

	# Allow building with python-2.5 (bug #149138)
	# Backported from upstream - should be in 3.0.3
	sed -i 's/\.2|^2\.3|^2\.4/.[2345]/' "${S}"/tools/check/check_python

	# Fix upstream's broken test cases (bug #141233)
	epatch "${FILESDIR}/${P}"-test-uuid.patch
	epatch "${FILESDIR}/${P}"-test-xauthority.patch

	# Fix compilation error with newer glibc (bug #151014)
	# Backported from upstream - should be in 3.0.3
	epatch "${FILESDIR}/${PVR}"/xc_ptrace.patch
}

src_compile() {
	local myopt myconf
	use debug && myopt="${myopt} debug=y"

	myconf="${myconf} $(use_enable vnc)"
	if use vnc ; then
		myconf="${myconf} --enable-sdl"
	else
		myconf="${myconf} $(use_enable sdl)"
	fi

	use custom-cflags || unset CFLAGS
	gcc-specs-ssp && append-flags -fno-stack-protector -fno-stack-protector-all

	(cd tools/ioemu && econf ${myconf}) || die "configure failured"
	emake -C tools ${myopt} || die "compile failed"

	if use doc; then
		sh ./docs/check_pkgs || die "package check failed"
		emake -C docs || die "compiling docs failed"
	fi

	emake -C docs man-pages || die "make man-pages failed"
}

src_install() {
	local myopt="XEN_PYTHON_NATIVE_INSTALL=1"

	make DESTDIR="${D}" ${myopt} install-tools \
		|| die "install failed"

	# Remove RedHat-specific stuff
	rm -rf "${D}"/etc/sysconfig

	if use doc; then
		make DESTDIR="${D}" -C docs install || die "install docs failed"
		# Rename doc/xen to the Gentoo-style doc/xen-x.y
		mv "${D}"/usr/share/doc/{${PN},${PF}}
	fi

	doman docs/man?/*

	newinitd "${FILESDIR}/${PVR}"/xend.initd xend
	newconfd "${FILESDIR}"/xendomains.confd xendomains
	newinitd "${FILESDIR}/${PVR}"/xendomains.initd xendomains

	if use screen; then
		cat "${FILESDIR}"/xendomains-screen.confd >> "${D}"/etc/conf.d/xendomains
		cp "${FILESDIR}"/xen-consoles.logrotate "${D}"/etc/xen/
		keepdir /var/log/xen-consoles
	fi

	# xend expects these to exist
	keepdir /var/run/xenstored /var/lib/xenstored /var/xen/dump
}

pkg_postinst() {
	elog "Please visit the Xen and Gentoo wiki:"
	elog "http://gentoo-wiki.com/HOWTO_Xen_and_Gentoo"

	if ! built_with_use dev-lang/python ncurses; then
		echo
		ewarn "NB: Your dev-lang/python is built without USE=ncurses."
		ewarn "Please rebuild python with USE=ncurses to make use of xenmon.py."
	fi

	if grep -qsF XENSV= "${ROOT}/etc/conf.d/xend"; then
		echo
		elog "xensv is broken upstream (Gentoo bug #142011)."
		elog "Please remove '${ROOT%/}/etc/conf.d/xend', as it is no longer needed."
	fi
}
