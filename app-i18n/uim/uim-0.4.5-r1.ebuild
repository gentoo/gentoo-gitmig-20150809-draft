# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/uim/uim-0.4.5-r1.ebuild,v 1.4 2005/01/12 18:38:57 gmsoft Exp $

inherit eutils flag-o-matic

MY_P="${PN}-rev1650"
PRIME_SCM="prime_2004-12-13.scm"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="a simple, secure and flexible input method library"
HOMEPAGE="http://uim.freedesktop.org/"
#SRC_URI="http://freedesktop.org/Software/UimDownload/${MY_P}.tar.gz"
SRC_URI="http://freedesktop.org/~tkng/${MY_P}.tar.gz
	http://prime.sourceforge.jp/src/${PRIME_SCM}"

LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="~x86 ~alpha ~ppc ~amd64 ~ppc64 ~sparc hppa"
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

get_gtk_confdir() {
	if useq amd64 || ( [ "${CONF_LIBDIR}" == "lib32" ] && useq x86 ) ; then
		echo "/etc/gtk-2.0/${CHOST}"
	else
		echo "/etc/gtk-2.0"
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-gtk-query-immodules-gentoo.diff
	use X || sed -i -e '/^SUBDIRS/s/xim//' Makefile.in || die
	cp ${DISTDIR}/${PRIME_SCM} scm/prime.scm || die
}

src_compile() {

	use debug && append-flags -g
	econf $(use_enable nls) \
		$(use_with X x) \
		$(use_with gtk gtk2) \
		$(use_with m17n-lib m17nlib) \
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
	einfo "To use uim-canna you should emerge app-i18n/canna."
	einfo "To use uim-skk you should emerge app-i18n/skk-jisyo (uim doesn't support skkserv)."
	einfo "To use uim-prime you should emerge >=app-i18n/prime-0.8."
	einfo

	ewarn
	ewarn "New input method switcher has been introduced. You need to set"
	ewarn
	ewarn "% GTK_IM_MODULE=uim ; export GTK_IM_MODULE"
	ewarn "% XMODIFIERS=@im=uim ; export XMODIFIERS"
	ewarn
	ewarn "If you would like to use uim-anthy as default input method, put"
	ewarn "(define default-im-name 'anthy)"
	ewarn "to your ~/.uim."
	ewarn
	ewarn "Available input methods can be found by running uim-im-switcher."
	ewarn

	use gtk && gtk-query-immodules-2.0 > ${ROOT}$(get_gtk_confdir)/gtk.immodules
}

pkg_postrm() {
	use gtk && gtk-query-immodules-2.0 > ${ROOT}$(get_gtk_confdir)/gtk.immodules
}
