# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/php-gtk/php-gtk-2.0.1-r3.ebuild,v 1.3 2010/07/25 19:10:00 nirbheek Exp $

EAPI="2"

PHP_EXT_NAME="php_gtk2"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
PHPSAPILIST="cli"
DOCS="AUTHORS ChangeLog INSTALL NEWS README README.KNOWN-ISSUES TODO2"

inherit php-ext-source-r1 virtualx

DESCRIPTION="PHP 5 bindings for the Gtk+ 2 library."
HOMEPAGE="http://gtk.php.net/"
SRC_URI="http://gtk.php.net/distributions/${P}.tar.gz"
IUSE="debug doc examples +glade gtkhtml libsexy mozembed scintilla spell"
LICENSE="PHP-2.02 PHP-3 PHP-3.01 LGPL-2.1 public-domain Scintilla"
SLOT="0"
KEYWORDS="~amd64 ~x86"

MYDOC_PN="php_gtk_manual"
MYDOC_PV="20071130"

LANGS="bg en ja pt_BR zh_CN"
for lang in ${LANGS} ; do
	IUSE="${IUSE} linguas_${lang}"
	SRC_URI="${SRC_URI}
		doc? ( linguas_${lang}? ( http://dev.gentooexperimental.org/~jakub/distfiles/${MYDOC_PN}-${MYDOC_PV}_${lang}.tar.bz2
					    mirror://gentoo/${MYDOC_PN}-${MYDOC_PV}_${lang}.tar.bz2 ) )"
done

RDEPEND=">=dev-lang/php-5.1.2
	<dev-lang/php-5.3[pcre,cli,debug=]
	>=x11-libs/gtk+-2.6.0
	>=dev-libs/glib-2.6.0
	>=x11-libs/pango-1.8.0
	>=dev-libs/atk-1.9.0
	glade? ( >=gnome-base/libglade-2.5.0 )
	libsexy? ( >=x11-libs/libsexy-0.1.10 )
	gtkhtml? ( gnome-extra/gtkhtml:3.14 )
	mozembed? ( >=www-client/firefox-1.5.0 )
	spell? ( >=app-text/gtkspell-2.0.0 )"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"

src_unpack() {
	unpack ${P}.tar.gz

	cd "${WORKDIR}"
	for lang in ${LANGS} ; do
		if use doc && use linguas_${lang} ; then
			mkdir ${lang}
			pushd ${lang} >/dev/null
			unpack ${MYDOC_PN}-${MYDOC_PV}_${lang}.tar.bz2
			popd >/dev/null
		fi
	done
}

src_prepare() {
	# we already check for CLI and built-in check creates trouble
	# on suhosin-based installations, so we remove it
	epatch "${FILESDIR}"/${PN}-2.0.0-no-cli-check.patch

	# depends on newer gtkhtml
	epatch "${FILESDIR}"/${PN}-2.0.1-gtkhtml314.patch

	# see bug 232538 for details:
	# this is needed so that autoconf can find the m4 gtk files (non-standard
	# location)
	export AT_M4DIR="${S}"
	# phpize will invoke autoconf/autoheader (which will fail); we are replacing
	# these calls with dummies as we call eautoreconf shortly afterwards
	# anyway
	export PHP_AUTOCONF="true"
	export PHP_AUTOHEADER="true"
	php-ext-source-r1_phpize
}

src_compile() {
	my_conf="--without-extra \
		$(use_with gtkhtml html) \
		$(use_with libsexy) \
		$(use_with mozembed) \
		$(use_with spell) \
		$(use_enable debug) \
		$(use_enable scintilla) \
		--without-sourceview \
		$(use glade || echo '--without-libglade')"
	# call virtualmake to setup an virtual x environment
	export maketype="php-ext-source-r1_src_compile"
	virtualmake
}

src_install() {
	php-ext-source-r1_src_install

	if use doc; then
		for lang in ${LANGS} ; do
			if use linguas_${lang} ; then
				ebegin "Installing ${lang} manual, will take a while"
				insinto /usr/share/doc/${CATEGORY}/${PF}/manual-${lang}
				doins -r "${WORKDIR}"/${lang}/html/*
				eend $?
			fi
		done
	fi

	if use examples	; then
		insinto /usr/share/doc/${CATEGORY}/${PF}/examples
		doins -r "${S}"/demos/*
	fi
}
