# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/xen-tools/xen-tools-3.0.2-r3.ebuild,v 1.1 2006/08/14 07:11:47 aross Exp $

inherit mount-boot flag-o-matic distutils eutils multilib

DESCRIPTION="Xend daemon and tools"
HOMEPAGE="http://xen.sourceforge.net"
if [[ ${PV} == *_p* ]]; then
	XEN_UNSTABLE="xen-unstable-${PV#*_p}"
	SRC_URI="mirror://gentoo/${XEN_UNSTABLE}.tar.bz2"
	S="${WORKDIR}/${XEN_UNSTABLE}"
else
	SRC_URI="http://www.cl.cam.ac.uk/Research/SRG/netos/xen/downloads/xen-${PV}-src.tgz"
	S="${WORKDIR}/xen-${PV}"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc debug screen custom-cflags hardened vnc sdl"

CDEPEND="dev-lang/python
	sys-libs/zlib
	sdl? ( media-libs/libsdl )
	vnc? ( media-libs/libsdl )"

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
	>=app-emulation/xen-3.0.2
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
		eerror "xend doesn't work when python is built with stack smashing protection (ssp)."
		eerror "Please append the following to your CFLAGS and remerge python:"
		eerror "  '-fno-stack-protector -fno-stack-protector-all'"
		die "python was built with stack smashing protection (ssp)"
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
	# for some reason the xen gcc checks don't work on gentoo-hardened
	if use hardened; then
		HARDFLAGS="-nopie -fno-stack-protector -fno-stack-protector-all"
		sed -e "s/CFLAGS :=/CFLAGS := ${HARDFLAGS}/" \
		-i "${S}"/tools/firmware/hvmloader/Makefile \
		"${S}"/tools/firmware/vmxassist/Makefile
	fi

	# Disable the 32bit-only vmxassist, if we are not on x86 and we don't support the x86 ABI
	if ! use x86 && ! has x86 $(get_all_abis); then
		sed -i -e "/SUBDIRS += vmxassist/d" "${S}"tools/firmware/Makefile
	fi

	# Fixes for hardened and amd64
	epatch "${FILESDIR}"/${P}-bxclobber.patch
	epatch "${FILESDIR}"/${P}-pushpop.patch

	# Allow --as-needed LDFLAGS
	epatch "${FILESDIR}/${P}"--as-needed.patch

	# Fix upstream's broken test cases (bug #141233)
	epatch "${FILESDIR}/${P}"-test-uuid.patch
	epatch "${FILESDIR}/${P}"-test-xauthority.patch
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

	newinitd "${FILESDIR}"/xend-init xend
	newconfd "${FILESDIR}"/xendomains.confd xendomains
	newinitd "${FILESDIR}"/xendomains.initd xendomains

	if use screen; then
		cat "${FILESDIR}"/xendomains-screen.confd >> "${D}"/etc/conf.d/xendomains
		cp "${FILESDIR}"/xen-consoles.logrotate "${D}"/etc/xen/
		keepdir /var/log/xen-consoles
	fi

	# xend expects these to exist
	keepdir /var/run/xenstored /var/lib/xenstored /var/xen/dump


	# for upstream change tracking
	if [[ -n ${XEN_UNSTABLE} ]]; then
		dodoc "${S}"/XEN-VERSION
	fi
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

	if [[ -n ${XEN_UNSTABLE} ]]; then
		echo
		elog "This is a snapshot of the xen-unstable tree."
		elog "Please report bugs in xen itself (and not the packaging) to"
		elog "bugzilla.xensource.com"
	fi
}
