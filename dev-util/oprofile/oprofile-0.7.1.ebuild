# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/oprofile/oprofile-0.7.1.ebuild,v 1.1 2004/02/01 19:57:28 spock Exp $

DESCRIPTION="A transparent low-overhead system-wide profiler"
HOMEPAGE="http://oprofile.sourceforge.net"
SRC_URI="mirror://sourceforge/oprofile/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
# IUSE: it also needs kernel sources but all gentoo users have them
IUSE="qt"
DEPEND=">=dev-libs/popt-1.7-r1
	>=sys-devel/binutils-2.14.90.0.6-r3
	>=sys-libs/glibc-2.3.2-r1
	qt? ( >=x11-libs/qt-3.2.1-r2 )"

src_compile() {
	check_KV

	local myconf=""

	use qt ||  myconf="${myconf} --with-qt-dir=/void"

	myconf="${myconf} --with-x"
	# note: compilation has only been tested with a 2.4 kernel
	case $KV in
	2.2.*|2.4.*) myconf="${myconf} --with-linux=/usr/src/linux";;
	2.5.*|2.6.*) myconf="${myconf} --with-kernel-support";;
	*) die "Kernel version '$KV' not supported";;
	esac
	econf ${myconf} || die "econf failed"

	local mymake=""

	sed -i -e "s,depmod -a,:,g" Makefile
	emake ${mymake} || die "emake failed"
}

src_install() {
	local myinst=""

	myinst="${myinst} MODINSTALLDIR=${D}/lib/modules/${KV}"
	make DESTDIR=${D} ${myinst} install || die "make install failed"

	dodoc ChangeLog* README TODO
}

pkg_postinst() {
	# media-video/nvidia-kernel does the following:
	[ -x /usr/sbin/update-modules ] && /usr/sbin/update-modules

	echo
	einfo "Now load the oprofile module by running:"
	einfo "  # opcontrol --init"
	einfo "Then read manpages and this html doc:"
	einfo "  /usr/share/doc/oprofile/oprofile.html"
	echo
}
