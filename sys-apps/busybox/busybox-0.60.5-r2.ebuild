# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/busybox/busybox-0.60.5-r2.ebuild,v 1.3 2004/02/04 00:07:15 solar Exp $

inherit flag-o-matic

S=${WORKDIR}/${P}
DESCRIPTION="Utilities for rescue and embedded systems"
SRC_URI="http://www.busybox.net/downloads/${P}.tar.gz"
HOMEPAGE="http://www.busybox.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 -alpha"
IUSE="static uclibc diet"

DEPEND="virtual/glibc
	diet? ( dev-libs/dietlibc )"
RDEPEND="!static? ${DEPEND}"

src_unpack() {
	unpack ${A}
	cp ${FILESDIR}/Config.h-${PV}-cd ${S}/Config.h
	# I did not include the msh patch since I don't know if it will
	# break stuff, I compile ash anyway, and it's in CVS

	# Add support for dietlibc - solar@gentoo.org
	if [ "`use diet`" != "" ]; then
		[ "${PV}" == "0.60.5" ] &&
		sed \
			-e "s://#define.*BB_TTY:#define BB_TTY:g" \
			-e "s://#define.*BB_WATCH:#define BB_WATCH:g" \
			-e "s:BB_TRACEROUTE:BB_TRACEROUTE_${RANDOM}:g" \
			< ${S}/Config.h > ${S}/Config.h.new &&
			mv ${S}/Config.h{.new,}
		[ -f ${FILESDIR}/${PN}-${PV}-dietlibc.diff ] &&
			epatch ${FILESDIR}/${PN}-${PV}-dietlibc.diff ||
			ewarn "No dietlibc patch found for ${PN}-${PV}"
	fi
}

src_compile() {
	local myconf

	use static && myconf="${myconf} DOSTATIC=true"
	if [ `use uclibc` ]; then
		myconf="${myconf} \
			CC=/usr/i386-linux-uclibc/bin/i386-uclibc-gcc \
			USE_SYSTEM_PWD=false"
		unset CFLAGS
	fi

	if [ "`use diet`" != "" ] ; then
		append-flags -D_BSD_SOURCE
		emake CC="diet ${CC}" CLFAGS="${CFLAGS}" ${myconf} ||
			die "Failed to make diet ${PN}"
	else
		emake ${myconf} || die
	fi
}

src_install() {
	into /
	dobin busybox
	into /usr
	dodoc AUTHORS Changelog LICENSE README TODO

	cd docs
	doman *.1
	docinto txt
	dodoc *.txt
	docinto pod
	dodoc *.pod
	dohtml *.html
	dohtml *.sgml

	cd ../scripts
	docinto scripts
	dodoc inittab
	dodoc depmod.pl
}

pkg_postinst() {
	einfo ""
	einfo "Edit /usr/portage/sys-apps/busybox/files/Config.h-${PV}-cd and"
	einfo "re-emerge if you need to add/remove functionality in "
	einfo "BusyBox."
	einfo ""
}
