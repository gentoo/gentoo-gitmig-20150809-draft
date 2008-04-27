# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/mediawiki/mediawiki-1.12.0.ebuild,v 1.1 2008/04/27 06:41:15 wrobel Exp $

EAPI="1"
inherit webapp depend.php versionator eutils

MY_BRANCH=$(get_version_component_range 1-2)

DESCRIPTION="The MediaWiki wiki web application (as used on wikipedia.org)"
HOMEPAGE="http://www.mediawiki.org"
SRC_URI="http://download.wikimedia.org/mediawiki/${MY_BRANCH}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="imagemagick math mysql postgres restrict +ocamlopt"

DEPEND="math? ( >=dev-lang/ocaml-3.0.6 )"
RDEPEND="${DEPEND}
	math? (
		app-text/dvipng
		virtual/tetex
		virtual/ghostscript
		media-gfx/imagemagick
	)
	imagemagick? ( media-gfx/imagemagick )"

RESTRICT="test"

need_httpd_cgi
need_php_httpd

pkg_setup() {
	webapp_pkg_setup
	local flags="pcre session xml"
	use mysql && flags="${flags} mysql"
	use postgres && flags="${flags} postgres"
	if ! PHPCHECKNODIE="yes" require_php_with_use ${flags} || \
		! PHPCHECKNODIE="yes" require_php_with_any_use gd gd-external ; then
			die "Re-install ${PHP_PKG} with ${flags} and either gd or gd-external"
	fi

	# see Bug 204812
	if use ocamlopt && use math && ! built_with_use --missing true dev-lang/ocaml ocamlopt; then
		eerror "In order to build ${PN} with native code support from ocaml"
		eerror "You first need to have a native code ocaml compiler."
		eerror "You need to install dev-lang/ocaml with ocamlopt useflag on."
		die "Please install ocaml with ocamlopt useflag"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# XXX: besides, is/was this patch really that required? if so, why? (trapni)
#	epatch ${FILESDIR}/jobindexlength-mysql.patch

	if use restrict ; then
		epatch "${FILESDIR}/access_restrict.patch"
	fi
}

src_compile() {
	if use math; then
		einfo "Compiling math support"
		cd math || die
		if ! use ocamlopt; then
			sed -i -e "s/ocamlopt/ocamlc/" Makefile
			sed -i -e "s/cmxa/cma/" Makefile
			sed -i -e "s/cmx/cmo/g" Makefile
		fi
		emake || die
	else
		einfo "No math support enabled. Skipping."
	fi

	# TODO: think about includes/zhtable/ support
}

src_install() {
	webapp_src_preinst

	# copy the app's main files excluding math support, docs, and tests
	local DIRS=(
		"bin"
		"config"
		"extensions"
		"images"
		"includes"
		"includes/api"
		"includes/cbt"
		"includes/filerepo"
		"includes/media"
		"includes/normal"
		"includes/templates"
		"includes/zhtable"
		"languages"
		"languages/classes"
		"languages/messages"
		"locale"
		"maintenance"
		"maintenance/archives"
		"maintenance/dtrace"
		"maintenance/language"
		"maintenance/ora"
		"maintenance/postgres"
		"maintenance/postgres/archives"
		"maintenance/storage"
		"serialized"
		"skins"
		"skins/chick"
		"skins/common"
		"skins/common/images"
		"skins/common/images/icons"
		"skins/disabled"
		"skins/htmldump"
		"skins/monobook"
		"skins/myskin"
		"skins/simple"
	)

	insinto ${MY_HTDOCSDIR}
	doins *.php *.inc *.phtml
	for DIR in ${DIRS[*]}; do
		insinto ${MY_HTDOCSDIR}/${DIR}
		doins ${DIR}/*
		[[ -f ${DIR}/.htaccess ]] && doins ${DIR}/.htaccess
	done

	# installing some docs
	local DOCS="AdminSettings.sample FAQ HISTORY INSTALL README RELEASE-NOTES UPGRADE"
	dodoc ${DOCS} docs/*.txt
	rm -f ${DOCS} COPYING docs/*.txt

	docinto php-memcached
	dodoc docs/php-memcached/*

	# If imagemagick is enabled then setup for image upload.
	# We ensure the directory is prepared for writing.  The post-
	# install instructions guide the user to enable the feature.
	if use imagemagick; then
		webapp_serverowned ${MY_HTDOCSDIR}/images
	fi

	# If we've enabled math USE-flag, install math support.
	# We ensure the directories are prepared for writing.  The post-
	# install instructions guide the user to enable the feature.
	if use math; then
		einfo "Installing math support"
		exeinto ${MY_HTDOCSDIR}/math
		doexe math/texvc

		# Docs
		docinto math
		dodoc math/{README,TODO}

		# Working directories.  Server writeable.
		dodir ${MY_HTDOCSDIR}/images/math
		webapp_serverowned ${MY_HTDOCSDIR}/images/math
		dodir ${MY_HTDOCSDIR}/images/tmp
		webapp_serverowned ${MY_HTDOCSDIR}/images/tmp
	fi

	webapp_postinst_txt en "${FILESDIR}/postinstall-1.11-en.txt"
	webapp_src_install
}
