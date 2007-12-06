# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/owfs/owfs-2.7_p0.ebuild,v 1.1 2007/12/06 15:00:50 wschlich Exp $

inherit eutils

MY_P="${P/_/}"

DESCRIPTION="Access 1-Wire devices like a filesystem"
SRC_URI="mirror://sourceforge/owfs/${MY_P}.tar.gz"
HOMEPAGE="http://www.owfs.org/ http://owfs.sourceforge.net/"
LICENSE="GPL-2"
DEPEND="fuse? ( sys-fs/fuse )
	perl? ( dev-lang/perl dev-lang/swig )
	php? ( dev-lang/php dev-lang/swig )
	python? ( dev-lang/python dev-lang/swig )
	tcl? ( dev-lang/tcl )
	usb? ( dev-libs/libusb )"
KEYWORDS="~x86"
SLOT="0"
IUSE="debug fuse ftp httpd parport perl php python server tcl usb"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	if ! built_with_use dev-lang/php cli; then
		eerror "${PN} needs the command line interface (CLI) of php"
		eerror "Please re-emerge dev-lang/php with USE=cli"
		die "need dev-lang/php built with cli USE flag"
	fi
}

src_compile() {
	econf \
		$(use_enable debug) \
		$(use_enable fuse owfs) \
		$(use_enable ftp owftpd) \
		$(use_enable httpd owhttpd) \
		$(use_enable parport) \
		$(use_enable perl owperl) \
		$(use_enable php owphp) \
		$(use_enable python owpython) \
		$(use_enable server owserver) \
		$(use_enable tcl owtcl) \
		$(use_enable usb) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR=${D} install || die "emake install failed"
	dodoc README NEWS ChangeLog AUTHORS
}
