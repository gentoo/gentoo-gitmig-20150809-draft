# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/mcabber/mcabber-0.9.0.ebuild,v 1.1 2006/12/20 15:54:14 wschlich Exp $

DESCRIPTION="A small Jabber console client with various features, like MUC, SSL, PGP"
HOMEPAGE="http://www.lilotux.net/~mikael/mcabber/"
SRC_URI="http://www.lilotux.net/~mikael/${PN}/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~mips ~ppc ~sparc ~x86"

IUSE="ssl crypt"

LANGS="pl fr"
# localized help versions are installed only, when LINGUAS var is set
for i in ${LANGS}; do
	IUSE="${IUSE} linguas_${i}"
done;

DEPEND="ssl? ( >=dev-libs/openssl-0.9.7-r1 )
	crypt? ( >=app-crypt/gpgme-1.0.0 )
	>=dev-libs/glib-2.0.0
	sys-libs/ncurses"

src_compile() {
	econf \
		$(use_enable crypt gpgme) \
		$(use_with ssl) \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	make install DESTDIR=${D} || die "make install failed"
	# clean unneeded language documentation
	for i in ${LANGS}; do
		! use linguas_${i} && rm -rf ${D}/usr/share/${PN}/help/${i}
	done

	dodoc AUTHORS ChangeLog NEWS README TODO mcabberrc.example
	dodoc doc/README_PGP.txt

	# install example themes
	insinto /usr/share/${PN}/themes
	doins ${S}/contrib/themes/*

	# contrib scripts
	newbin ${S}/contrib/eventcmd ${PN}_eventcmd
	newbin ${S}/contrib/cicq2mcabber.pl ${PN}_cicq2mcabber.pl
	newbin ${S}/contrib/mcwizz.pl ${PN}_mcwizz.pl
}

pkg_postinst() {
	einfo
	einfo "MCabber requires you to create a subdirectory .mcabber in your home"
	einfo "directory and to place a configuration file there."
	einfo "An example mcabberrc was installed as part of the documentation."
	einfo "To create a new mcabberrc based on the example mcabberrc, execute the"
	einfo "following commands:"
	einfo
	einfo "  mkdir -p ~/.mcabber"
	einfo "  zcat ${ROOT}usr/share/doc/${PF}/mcabberrc.example.gz >~/.mcabber/mcabberrc"
	einfo
	einfo "Then edit ~/.mcabber/mcabberrc with your favorite editor."
	einfo
	einfo "As of MCabber version 0.8.2, there is also a wizard script"
	einfo "with which you can create all necessary configuration options."
	einfo "To use it, simply execute the following command:"
	einfo
	einfo "  ${PN}_mcwizz.pl"
	einfo
	einfo "See the CONFIGURATION FILE and FILES sections of the mcabber"
	einfo "manual page (section 1) for more information."
	einfo
	einfo "From version 0.9.0 on, MCabber supports PGP encryption of messages."
	einfo "See README_PGP.txt for details."
	einfo
}
