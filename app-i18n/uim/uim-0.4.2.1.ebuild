# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/uim/uim-0.4.2.1.ebuild,v 1.1 2004/07/30 23:45:36 matsuu Exp $

inherit eutils flag-o-matic

DESCRIPTION="a simple, secure and flexible input method library"
HOMEPAGE="http://uim.freedesktop.org/"
SRC_URI="http://freedesktop.org/Software/UimDownload/${P}.tar.gz"

LICENSE="GPL-2 | BSD"
SLOT="0"
KEYWORDS="~x86 ~alpha ~ppc ~amd64 ~ppc64 ~sparc"
IUSE="gtk nls debug X m17n-lib"

RDEPEND="X? ( virtual/x11 )
	gtk? ( >=x11-libs/gtk+-2 )
	m17n-lib? ( dev-libs/m17n-lib )
	!app-i18n/uim-svn
	!app-i18n/uim-fep"
DEPEND="${RDEPEND}
	dev-lang/perl
	dev-perl/XML-Parser
	>=sys-apps/sed-4
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-gtk-query-immodules-gentoo.diff
	use X || sed -i -e '/^SUBDIRS/s/xim//' Makefile.in || die
}

src_compile() {

	use debug && append-flags -g
	econf `use_enable nls` \
		`use_with X x` \
		`use_with gtk gtk2` \
		`use_with m17n-lib m17nlib` \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL* NEWS README*
	dodoc doc/{HELPER-CANDWIN,KEY,UIM-SH}
	use X && dodoc doc/XIM-SERVER
}

pkg_postinst() {
	einfo
	einfo "To use uim-anthy you should emerge app-i18n/anthy or app-i18n/anthy-ss."
	einfo "To use uim-skk you should emerge app-i18n/skk-jisyo (uim doesn't support skkserv)."
	einfo "To use uim-prime you should emerge >=app-i18n/prime-0.8."
	einfo

	use gtk && gtk-query-immodules-2.0 > ${ROOT}/etc/gtk-2.0/gtk.immodules
}

pkg_postrm() {
	use gtk && gtk-query-immodules-2.0 > ${ROOT}/etc/gtk-2.0/gtk.immodules
}
