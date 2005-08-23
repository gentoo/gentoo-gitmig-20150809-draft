# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/mediawiki/mediawiki-1.3.14.ebuild,v 1.1 2005/08/23 23:48:36 trapni Exp $

inherit webapp

DESCRIPTION="The MediaWiki wiki web application (as used on wikipedia.org)"
HOMEPAGE="http://www.mediawiki.org"
SRC_URI="mirror://sourceforge/wikipedia/${P}.tar.gz"
RESTRICT="nomirror"
LICENSE="GPL-2"
KEYWORDS="x86 amd64"
IUSE="imagemagick math"

DEPEND="math? ( >=dev-lang/ocaml-3.0.6 )"

RDEPEND="virtual/php
		 >=dev-db/mysql-4
		 math? ( app-text/tetex
		 		 app-text/ghostscript
				 media-gfx/imagemagick )
		 imagemagick? ( media-gfx/imagemagick )"

src_compile() {
	if use math; then
		einfo "Compiling math support"
		cd math || die
		emake || die
	else
		einfo "Nothing to compile"
	fi
}

src_install() {
	webapp_src_preinst

	# copy the app's main files excluding math support and docs
	local DIRS='config images includes languages languages/wikipedia
			maintenance maintenance/archives maintenance/postgresql
			stylesheets stylesheets/davinci stylesheets/images
			stylesheets/mono stylesheets/monobook
			stylesheets/myskin templates
			PHPTAL-NP-0.7.0 PHPTAL-NP-0.7.0/libs
			PHPTAL-NP-0.7.0/libs/Algo PHPTAL-NP-0.7.0/libs/PHPTAL
			PHPTAL-NP-0.7.0/libs/PHPTAL/Attribute
			PHPTAL-NP-0.7.0/libs/PHPTAL/Attribute/I18N
			PHPTAL-NP-0.7.0/libs/PHPTAL/Attribute/METAL
			PHPTAL-NP-0.7.0/libs/PHPTAL/Attribute/PHPTAL
			PHPTAL-NP-0.7.0/libs/PHPTAL/Attribute/TAL
			PHPTAL-NP-0.7.0/libs/Types'
	insinto ${MY_HTDOCSDIR}
	doins *.php *.inc *.phtml
	for DIR in ${DIRS}; do
		dodir ${MY_HTDOCSDIR}/${DIR}
		insinto ${MY_HTDOCSDIR}/${DIR}
		doins ${DIR}/*
	done

	# installing some docs
	local DOCS="COPYING HISTORY INSTALL README RELEASE-NOTES UPGRADE AdminSettings.sample"
	for DOC in ${DOCS}; do
		dodoc "${DOC}"
		rm -f "${DOC}"
	done
	dodoc docs/*.doc
	rm -f docs/*.doc

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
		dodir ${MY_HTDOCSDIR}/math
		exeinto ${MY_HTDOCSDIR}/math
		doexe math/texvc

		# Docs
		docinto math
		dodoc math/README math/TODO

		# Working directories.  Server writeable.
		dodir ${MY_HTDOCSDIR}/images/math
		webapp_serverowned ${MY_HTDOCSDIR}/images/math
		dodir ${MY_HTDOCSDIR}/images/tmp
		webapp_serverowned ${MY_HTDOCSDIR}/images/tmp
	fi

	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt
	webapp_src_install
}
