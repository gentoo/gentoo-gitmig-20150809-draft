# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/epic4/epic4-1.2.6.ebuild,v 1.6 2004/08/02 21:12:09 swegener Exp $

inherit flag-o-matic eutils

DESCRIPTION="Epic4 IRC Client"
HOMEPAGE="http://epicsol.org/"
SRC_URI="ftp://ftp.epicsol.org/pub/epic/EPIC4-BETA/${P}.tar.bz2
	 ftp://prbh.org/pub/epic/EPIC4-PRODUCTION/epic4-help-20030114.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc ~ia64 ~alpha ~hppa"
IUSE="ipv6 perl ssl tcltk"

DEPEND=">=sys-libs/ncurses-5.2
	perl? ( >=dev-lang/perl-5.6.1 )
	ssl? ( >=dev-libs/openssl-0.9.5 )
	tcltk? ( dev-lang/tcl )"

src_compile() {
	replace-flags "-O?" "-O"

	myconf=""

	myconf="${myconf} `use_with ipv6`"
	myconf="${myconf} `use_with perl`"
	myconf="${myconf} `use_with ssl`"
	myconf="${myconf} `use_with tcltk`"

	epatch ${FILESDIR}/epic-defaultserver.patch || die "patch failed"

	econf \
		--libexecdir=/usr/lib/misc \
		${myconf} || die "econf failed"

	make || die "make failed"
}

src_install () {
	einstall \
		sharedir=${D}/usr/share \
		libexecdir=${D}/usr/lib/misc || die "einstall failed"

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

	if [ ! -f ${ROOT}/usr/share/epic/script/local ]; then
		cp ${FILESDIR}/local ${ROOT}/usr/share/epic/script/
	fi
}
