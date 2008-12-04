# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/php-gtk/php-gtk-2.0.0.ebuild,v 1.3 2008/12/04 20:54:08 eva Exp $

EAPI="1"

PHP_EXT_NAME="php_gtk2"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
PHPSAPILIST="cli"
DOCS="AUTHORS ChangeLog INSTALL NEWS README README.KNOWN-ISSUES TODO2"

inherit php-ext-source-r1

DESCRIPTION="PHP 5 bindings for the Gtk+ 2 library."
HOMEPAGE="http://gtk.php.net/"
SRC_URI="http://gtk.php.net/distributions/${P}.tar.gz"
IUSE="debug doc examples extra +glade html libsexy mozembed scintilla spell"
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
	>=x11-libs/gtk+-2.6.0
	>=dev-libs/glib-2.6.0
	>=x11-libs/pango-1.8.0
	>=dev-libs/atk-1.9.0
	extra? ( >=x11-libs/gtk+extra-2.1.1 )
	glade? ( >=gnome-base/libglade-2.5.0 )
	html? ( >=gnome-extra/gtkhtml-3.10.0:3.8 )
	libsexy? ( >=x11-libs/libsexy-0.1.10 )
	mozembed? ( >=www-client/mozilla-firefox-1.5.0 )
	spell? ( >=app-text/gtkspell-2.0.0 )"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"

pkg_setup() {
	if use debug ; then
		require_php_with_use cli pcre debug
	else
		if has_debug ; then
			# PHP has debug enabled, but PHP-GTK doesn't!
			eerror "Please enable the 'debug' USE flag in PHP-GTK."
			eerror "This is needed to work with the debug version of PHP."
			die "Enable 'debug' USE flag for dev-lang/php"
		fi
		require_php_with_use cli pcre
	fi
}

src_unpack() {
	unpack ${P}.tar.gz

	cd "${S}"
	# we already check for CLI and built-in check creates trouble
	# on suhosin-based installations, so we remove it
	epatch "${FILESDIR}"/${P}-no-cli-check.patch

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

src_compile() {
	local GLCONF
	use glade || GLCONF=" --without-libglade"

	# php-ext-source-r1_src_compile can't be used
	has_php
	addpredict /usr/share/snmp/mibs/.index
	addpredict /session_mm_cli0.sem
	./buildconf

	econf $(use_with extra) \
		$(use_with html) \
		$(use_with libsexy) \
		$(use_with mozembed) \
		$(use_with spell) \
		$(use_with debug) \
		$(use_enable scintilla) \
		--without-sourceview \
		${GLCONF}

	emake || die "make failed!"
	mv -f "modules/${PHP_EXT_NAME}.so" "${WORKDIR}/${PHP_EXT_NAME}-default.so" || die "Unable to move extension"
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
