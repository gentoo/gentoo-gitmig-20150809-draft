# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/lcdproc/lcdproc-0.4.3-r2.ebuild,v 1.7 2004/04/06 04:19:50 vapier Exp $

inherit eutils

DESCRIPTION="Client/Server suite to drive all kinds of LCD (-like) devices"
HOMEPAGE="http://lcdproc.org/"
SRC_URI="mirror://sourceforge/lcdproc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="doc ncurses svga"

DEPEND=">=sys-apps/baselayout-1.6.4
	>=sys-apps/sed-4
	doc? ( >=app-text/docbook-sgml-utils-0.6.11-r2 )
	ncurses? ( >=sys-libs/ncurses-5.3 )
	svga? ( >=media-libs/svgalib-1.4.3 )"

src_unpack() {
	unpack ${A} || die
	cd ${S}

	sed -i "889s:-O3:${CFLAGS}:" configure

	# fix a few bugs ;)
	epatch ${FILESDIR}/${P}-gentoo.diff
}

src_compile() {
	# By default, all drivers that are supported by the given plattform/hardware
	# are compiled (of course respecting the existing USE flags). If the
	# LCDPROC_DRIVERS environment variable is set to a comma separated list, only
	# the specified drivers will be compiled.
	# Example:
	#
	#   env LCDPROC_DRIVERS="curses,CFontz" emerge lcdproc
	#
	# NOTE: The ebuild still respects your USE variable and will not install any
	# additional packages unless the corresponding USE flag is set!
	# You might have to alter it if e.g. ncurses is normally not part of your
	# USE variable.
	# Example:
	#
	#   env USE="$USE ncurses" LCDPROC_DRIVERS="curses,CFontz" emerge lcdproc

	local myconf

	myconf="--enable-drivers=mtxorb,cfontz,text,lb216,hd44780,joy,irman,lircin,"
	myconf="${myconf}bayrad,glk,stv5730,sed1330,sed1520,lcdm001,t6963"

	use ncurses && myconf="${myconf},curses"
	use svga && myconf="${myconf},svgalib"

	[ x"${LCDPROC_DRIVERS}" = x ] || \
		myconf="--enable-drivers=${LCDPROC_DRIVERS}"

	use samba && myconf="${myconf} --enable-stat-smbfs"
	myconf="${myconf} --enable-stat-nfs"

	econf ${myconf} || die
	emake || die

	if use doc ; then
		cd ${S}/docs/lcdproc-user
		docbook2html lcdproc-user.docbook
	fi
}

src_install() {
	dosbin server/LCDd
	dobin clients/lcdproc/lcdproc

	doman docs/lcdproc.1 docs/LCDd.8

	dodoc README ChangeLog INSTALL

	if use doc ; then
		insinto /usr/share/doc/${PF}/lcdproc-user
		doins docs/lcdproc-user/*.html
	fi

	docinto olddocs
	dodoc docs/README.dg* docs/*.txt

	insinto /usr/share/doc/${PF}/clients/examples
	doins clients/examples/*.pl
	insinto /usr/share/doc/${PF}/clients/headlines
	doins clients/headlines/lcdheadlines

	insinto /etc
	doins LCDd.conf
	doins scripts/lcdproc.conf

	exeinto /etc/init.d
	doexe ${FILESDIR}/LCDd
	doexe ${FILESDIR}/lcdproc
}
