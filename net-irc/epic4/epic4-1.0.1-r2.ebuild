# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/epic4/epic4-1.0.1-r2.ebuild,v 1.4 2003/07/18 18:47:41 azarah Exp $

IUSE=

DESCRIPTION="Epic4 IRC Client"
SRC_URI="ftp://prbh.org/pub/epic/EPIC4-PRODUCTION/${P}.tar.gz \
	ftp://prbh.org/pub/epic/EPIC4-PRODUCTION/epic4-help-20030114.tar.gz"
HOMEPAGE="http://www.epicsol.org"

DEPEND=">=sys-libs/ncurses-5.2"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc"

inherit eutils flag-o-matic gcc
replace-flags "-O?" "-O"

src_unpack() {
	unpack ${A}

	# Macro's in gcc-3.3 and later changed slightly ...
	if [ "`gcc-major-version`" -eq 3 -a "`gcc-minor-version`" -ge 3 ]
	then
		cd ${S}; epatch ${FILESDIR}/${P}-gcc33.patch
	fi
}

src_compile() {
	econf --libexecdir=/usr/lib/misc || die

	make || die
}

src_install () {
	einstall \
		sharedir=${D}/usr/share \
		libexecdir=${D}/usr/lib/misc || die

	rm ${D}/usr/bin/epic
	dosym epic-EPIC4-${PV} /usr/bin/epic
	dodoc BUG_FORM COPYRIGHT README KNOWNBUGS VOTES
	docinto doc
	cd doc
	dodoc *.txt colors EPIC* IRCII_VERSIONS local_vars missing new-load
	dodoc nicknames outputhelp server_groups SILLINESS TS4
	dodir /usr/share/epic
	tar xzvf ${DISTDIR}/epic4-help-20030114.tar.gz -C ${D}/usr/share/epic
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
