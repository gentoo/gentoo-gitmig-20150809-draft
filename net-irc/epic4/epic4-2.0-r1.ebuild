# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/epic4/epic4-2.0-r1.ebuild,v 1.12 2006/10/18 21:20:33 jokey Exp $

inherit flag-o-matic eutils

DESCRIPTION="Epic4 IRC Client"
HOMEPAGE="http://epicsol.org/"
SRC_URI="ftp://ftp.epicsol.org/pub/epic/EPIC4-PRODUCTION/${P}.tar.bz2
	ftp://prbh.org/pub/epic/EPIC4-PRODUCTION/epic4-help-20040801.tar.gz
	mirror://gentoo/epic4-local.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc ~ia64 alpha hppa sparc amd64 ppc-macos"
IUSE="ipv6 perl ssl"

DEPEND=">=sys-libs/ncurses-5.2
	perl? ( >=dev-lang/perl-5.6.1 )
	ssl? ( >=dev-libs/openssl-0.9.5 )"

pkg_setup() {
	if use perl && built_with_use dev-lang/perl ithreads
	then
		error "You need perl compiled with USE=\"-ithreads\" to be able to compile epic4."
		die "perl with USE=\"-ithreads\" needed"
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PV}-toggle-stop-screen.patch
	epatch ${FILESDIR}/epic-defaultserver.patch
}

src_compile() {
	replace-flags "-O?" "-O"

	econf \
		--libexecdir=/usr/lib/misc \
		`use_with ipv6` \
		`use_with perl` \
		`use_with ssl` \
		|| die "econf failed"
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
	tar zxvf ${DISTDIR}/epic4-help-20040801.tar.gz -C ${D}/usr/share/epic

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
		cp ${WORKDIR}/epic4-local ${ROOT}/usr/share/epic/script/local
	fi

	# Fix for bug 59075
	chmod 755 ${ROOT}/usr/share/epic/help
}
