# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/epic4/epic4-1.1.16-r1.ebuild,v 1.2 2004/01/11 23:14:42 gmsoft Exp $

IUSE="ipv6 perl ssl tcltk"

DESCRIPTION="Epic4 IRC Client"
SRC_URI="ftp://prbh.org/pub/epic/EPIC4-ALPHA/${P}.tar.bz2
	 ftp://prbh.org/pub/epic/EPIC4-PRODUCTION/epic4-help-20030114.tar.gz"
HOMEPAGE="http://epicsol.org"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~ppc ia64 ~alpha hppa amd64"

DEPEND=">=sys-libs/ncurses-5.2
	perl? ( >=dev-lang/perl-5.6.1 )
	ssl? ( >=dev-libs/openssl-0.9.5 )
	tcltk? ( dev-lang/tcl )"

inherit flag-o-matic
replace-flags "-O?" "-O"

src_compile() {
	myconf=""

	epatch ${FILESDIR}/epic-defaultserver.patch

	myconf="${myconf} `use_with ipv6`"
	myconf="${myconf} `use_with perl`"
	myconf="${myconf} `use_with ssl`"
	myconf="${myconf} `use_with tcltk`"

	econf \
		--libexecdir=/usr/lib/misc \
		${myconf} || die

	make || die
}

src_install () {
	einstall \
		sharedir=${D}/usr/share \
		libexecdir=${D}/usr/lib/misc || die

	rm -f ${D}/usr/bin/epic
	dosym epic-EPIC4-${PV} /usr/bin/epic

	dodoc BUG_FORM COPYRIGHT README KNOWNBUGS VOTES
	docinto doc
	cd doc
	dodoc *.txt colors EPIC* IRCII_VERSIONS local_vars missing new-load
	dodoc nicknames outputhelp server_groups SILLINESS TS4

	dodir /usr/share/epic
	tar zxvf ${DISTDIR}/epic4-help-20030114.tar.gz -C ${D}/usr/share/epic

	rm -f ${D}/usr/share/epic/help/Makefile
	rm -rf ${D}/usr/share/epic/help/CVS

	chown -R root:root ${D}/usr/share/epic/help
}

pkg_postinst() {
	einfo "If /usr/share/epic/script/local does not exist, I will now"
	einfo "create it.  If you do not like the look/feel of this file, or"
	einfo "if you'd prefer to use your own script, simply remove this"
	einfo "file.  If you want to prevent this file from being installed"
	einfo "in the future, simply create an empty file with this name."

	if [ ! -e /usr/share/epic/script/local ]; then
		cp ${FILESDIR}/local /usr/share/epic/script/
	fi
}
