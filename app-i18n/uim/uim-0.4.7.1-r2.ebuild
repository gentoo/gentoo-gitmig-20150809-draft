# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/uim/uim-0.4.7.1-r2.ebuild,v 1.6 2005/08/19 19:23:36 hansmi Exp $

inherit eutils kde-functions flag-o-matic

MY_P="${P/_/}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="a simple, secure and flexible input method library"
HOMEPAGE="http://uim.freedesktop.org/"
SRC_URI="http://uim.freedesktop.org/releases/${MY_P}.tar.gz
	http://prime.sourceforge.jp/src/prime-1.0.0.1.tar.gz"

LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="alpha ~amd64 ~hppa ppc ppc64 sparc x86"
IUSE="gtk qt immqt immqt-bc nls X m17n-lib canna"
#IUSE="${IUSE} scim"

RDEPEND="X? ( virtual/x11 )
	gtk? ( >=x11-libs/gtk+-2 )
	m17n-lib? ( dev-libs/m17n-lib )
	!app-i18n/uim-svn
	!app-i18n/uim-fep
	canna? ( app-i18n/canna )
	immqt? ( $(qt_min_version 3.3.4) )
	immqt-bc? ( $(qt_min_version 3.3.4) )
	qt? ( $(qt_min_version 3.3.4) )
	!<app-i18n/prime-0.9.4
	!app-i18n/uim-qt
	!app-i18n/uim-kdehelper"
DEPEND="${RDEPEND}
	dev-lang/perl
	dev-perl/XML-Parser
	>=sys-apps/sed-4
	sys-devel/autoconf
	sys-devel/automake
	sys-devel/libtool
	nls? ( sys-devel/gettext )"

# An arch specific config directory is used on multilib systems
has_multilib_profile && GTK2_CONFDIR="/etc/gtk-2.0/${CHOST}"
GTK2_CONFDIR=${GTK2_CONFDIR:=/etc/gtk-2.0/}

src_unpack() {
	unpack ${A}

	cd "${S}"
	# we execute gtk-query-immodules-2.0 in pkg_postinst()
	# to not violate sandbox.
	sed -i -e "/gtk-query-immodules-2.0/s/.*/	:\\\\/g" \
		Makefile.am || die
	use X || sed -i -e '/^SUBDIRS/s/xim//' Makefile.in || die
}

src_compile() {
	local myconf
	use qt && set-qtdir 3
	if use immqt || use immqt-bc ; then
		myconf="${myconf} --with-qt-immodule"
		export CPPFLAGS="${CPPFLAGS} -DQT_THREAD_SUPPORT"
	fi

	myconf="${myconf}
		$(use_enable nls)
		$(use_with X x)
		$(use_with gtk gtk2)
		$(use_with m17n-lib m17nlib)
		$(use_with canna)
		$(use_with qt)"

	autoreconf
	libtoolize --copy --force

	# --with-scim is not stable enough
	econf ${myconf} --without-scim || die "econf failed"
	emake -j1 || die "emake failed"

	if has_version '>=app-i18n/prime-1.0' ; then
		cd ${WORKDIR}/prime-1.0.0.1
		econf || die
	fi
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	if has_version '>=app-i18n/prime-1.0' ; then
		cd ${WORKDIR}/prime-1.0.0.1
		make DESTDIR="${D}" install-uim || die "make install-uim failed"
		cd -
	fi

	dodoc AUTHORS ChangeLog INSTALL* NEWS README*
	dodoc doc/{HELPER-CANDWIN,KEY,UIM-SH}
	use X && dodoc doc/XIM-SERVER
}

pkg_postinst() {
	einfo
	einfo "To use uim-anthy you should emerge app-i18n/anthy or app-i18n/anthy-ss."
	einfo "To use uim-skk you should emerge app-i18n/skk-jisyo."
	einfo "To use uim-prime you should emerge app-i18n/prime."
	einfo

	ewarn
	ewarn "New input method switcher has been introduced. You need to set"
	ewarn
	ewarn "% GTK_IM_MODULE=uim ; export GTK_IM_MODULE"
	ewarn "% QT_IM_MODULE=uim ; export QT_IM_MODULE"
	ewarn "% XMODIFIERS=@im=uim ; export XMODIFIERS"
	ewarn
	ewarn "If you would like to use uim-anthy as default input method, put"
	ewarn "(define default-im-name 'anthy)"
	ewarn "to your ~/.uim."
	ewarn
	ewarn "All input methods can be found by running uim-im-switcher-gtk"
	ewarn "or uim-im-switcher-qt."
	ewarn

	use gtk && gtk-query-immodules-2.0 > ${ROOT}/${GTK2_CONFDIR}/gtk.immodules
}

pkg_postrm() {
	use gtk && gtk-query-immodules-2.0 > ${ROOT}/${GTK2_CONFDIR}/gtk.immodules
}
