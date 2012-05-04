# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/mcabber/mcabber-0.10.0.ebuild,v 1.2 2012/05/04 06:22:11 jdhore Exp $

EAPI="2"

inherit flag-o-matic

DESCRIPTION="A small Jabber console client with various features, like MUC, SSL, PGP"
HOMEPAGE="http://mcabber.com/"
SRC_URI="http://mcabber.com/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~mips ~ppc ~ppc64 ~sparc ~x86"

IUSE="crypt otr spell ssl"

LANGS="de en fr nl pl uk ru"
# localized help versions are installed only, when LINGUAS var is set
for i in ${LANGS}; do
	IUSE="${IUSE} linguas_${i}"
done;

RDEPEND="ssl? ( net-libs/loudmouth[ssl] )
	crypt? ( >=app-crypt/gpgme-1.0.0 )
	>=net-libs/loudmouth-1.4.3
	otr? ( >=net-libs/libotr-3.1.0 )
	spell? ( app-text/aspell )
	>=dev-libs/glib-2.0.0
	sys-libs/ncurses"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	use crypt && append-flags -D_FILE_OFFSET_BITS=64 # bug #277888
	append-flags -fno-strict-aliasing
}

src_configure() {
	econf \
		--enable-modules \
		$(use_enable crypt gpgme) \
		$(use_enable otr) \
		$(use_enable spell aspell) \
		|| die "econf failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
	# clean unneeded language documentation
	for i in ${LANGS}; do
		! use linguas_${i} && rm -rf "${D}"/usr/share/${PN}/help/${i}
	done

	dodoc AUTHORS ChangeLog NEWS README TODO mcabberrc.example
	dodoc doc/README_PGP.txt

	# contrib themes
	insinto /usr/share/${PN}/themes
	doins "${S}"/contrib/themes/*

	# contrib generic scripts
	exeinto /usr/share/${PN}/scripts
	doexe "${S}"/contrib/*.{pl,py}

	# contrib event scripts
	exeinto /usr/share/${PN}/scripts/events
	doexe "${S}"/contrib/events/*
}

pkg_postinst() {
	elog
	elog "MCabber requires you to create a subdirectory .mcabber in your home"
	elog "directory and to place a configuration file there."
	elog "An example mcabberrc was installed as part of the documentation."
	elog "To create a new mcabberrc based on the example mcabberrc, execute the"
	elog "following commands:"
	elog
	elog "  mkdir -p ~/.mcabber"
	elog "  bzcat ${ROOT}usr/share/doc/${PF}/mcabberrc.example.bz2 >~/.mcabber/mcabberrc"
	elog
	elog "Then edit ~/.mcabber/mcabberrc with your favorite editor."
	elog
	elog "See the CONFIGURATION FILE and FILES sections of the mcabber"
	elog "manual page (section 1) for more information."
	elog
	elog "From version 0.9.0 on, MCabber supports PGP encryption of messages."
	elog "See README_PGP.txt for details."
	elog
	elog "Check out ${ROOT}usr/share/${PN} for contributed themes and event scripts."
	elog
}
