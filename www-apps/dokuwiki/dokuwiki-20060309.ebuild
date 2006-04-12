# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/dokuwiki/dokuwiki-20060309.ebuild,v 1.2 2006/04/12 01:22:49 ramereth Exp $

inherit webapp

# Upstream uses dashes in the datestamp
MY_PV="${PV:0:4}-${PV:4:2}-${PV:6:2}"

DESCRIPTION="DokuWiki is a simple to use Wiki aimed at a small companies
documentation needs."
HOMEPAGE="http://wiki.splitbrain.org/wiki:dokuwiki"
SRC_URI="http://www.splitbrain.org/_media/projects/${PN}/${PN}-${MY_PV}.tgz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="virtual/php"
RDEPEND="${DEPEND}"

src_unpack() {
	cd ${WORKDIR}
	unpack ${PN}-${MY_PV}.tgz
	mv ${PN}-${MY_PV} ${P}
}

src_compile() {
	# Default compile hangs
	echo "Nothing to compile"
}

src_install() {
	local docs="README"
	webapp_src_preinst

	# NOTE: doc files should go into /usr/share/doc, and NOT installed in the vhost
	einfo "Installing docs"
	dodoc ${docs}
	for doc in ${docs} COPYING; do
		rm -f ${doc}
	done

	einfo "Copying main files"
	cp -r . ${D}/${MY_HTDOCSDIR}

	# Install the htaccess file for pretty urls
	cp .htaccess ${D}/${MY_HTDOCSDIR}

	# Create initial changes file
	touch ${D}/${MY_HTDOCSDIR}/data/changes.log data/changes.log

	# The data dir needs to be owned by the server
	for x in `find . -print | grep "data/*" | grep -v .htaccess` ; do
		webapp_serverowned ${MY_HTDOCSDIR}/$x
	done

	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt
	webapp_configfile ${MY_HTDOCSDIR}/.htaccess
	# Commented out until I have time to fix this (bug #129473)
	#webapp_configfile ${MY_HTDOCSDIR}/conf/*
	webapp_src_install
}
