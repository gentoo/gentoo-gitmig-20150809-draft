# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/epic4/epic4-2.2.ebuild,v 1.1 2005/02/17 03:16:05 swegener Exp $

inherit flag-o-matic eutils

HELP_V="20040801"

DESCRIPTION="Epic4 IRC Client"
HOMEPAGE="http://epicsol.org/"
SRC_URI="ftp://ftp.epicsol.org/pub/epic/EPIC4-PRODUCTION/${P}.tar.bz2
	 ftp://prbh.org/pub/epic/EPIC4-PRODUCTION/epic4-help-${HELP_V}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc ~ia64 ~alpha ~hppa ~sparc ~amd64 ~ppc-macos"
IUSE="ipv6 perl ssl"

DEPEND=">=sys-libs/ncurses-5.2
	perl? ( >=dev-lang/perl-5.6.1 )
	ssl? ( >=dev-libs/openssl-0.9.5 )"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/epic-defaultserver.patch

	rm -f ${WORKDIR}/help/Makefile
	find ${WORKDIR}/help -type d -name CVS -print0 | xargs -0 rm -r
}

src_compile() {
	replace-flags "-O?" "-O"

	econf \
		--libexecdir=/usr/lib/misc \
		$(use_with ipv6) \
		$(use_with perl) \
		$(use_with ssl) \
		|| die "econf failed"
	emake || die "make failed"
}

src_install () {
	einstall \
		sharedir=${D}/usr/share \
		libexecdir=${D}/usr/lib/misc || die "einstall failed"

	dodoc BUG_FORM COPYRIGHT README KNOWNBUGS VOTES

	cd ${S}/doc
	docinto doc
	dodoc \
		*.txt colors EPIC* IRCII_VERSIONS local_vars missing new-load \
		nicknames outputhelp SILLINESS TS4

	mv ${WORKDIR}/help/* ${D}/usr/share/epic/help
}

pkg_postinst() {
	einfo "If /usr/share/epic/script/local does not exist, I will now"
	einfo "create it.  If you do not like the look/feel of this file, or"
	einfo "if you'd prefer to use your own script, simply remove this"
	einfo "file.  If you want to prevent this file from being installed"
	einfo "in the future, simply create an empty file with this name."

	if [ ! -f ${ROOT}/usr/share/epic/script/local ]
	then
		cp ${FILESDIR}/local ${ROOT}/usr/share/epic/script/
	fi

	# Fix for bug 59075
	chmod 755 ${ROOT}/usr/share/epic/help
}
