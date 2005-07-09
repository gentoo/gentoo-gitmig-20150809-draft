# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_dav_svn/mod_dav_svn-1.1.1.ebuild,v 1.2 2005/07/09 15:42:35 agriffis Exp $

# FIXME this ebuild acutally installes mod_dav_svn *and* mod_authz_svn... 
# what about this? shall it be splitted up, too?

inherit eutils depend.apache

MY_P="${P/mod_dav_svn/subversion}"
MY_P="${MY_P/_rc/-rc}"

DESCRIPTION="The apache front end module for Subversion."
SRC_URI="http://subversion.tigris.org/tarballs/${MY_P}.tar.bz2"
HOMEPAGE="http://subversion.tigris.org/"

SLOT="0"
LICENSE="Apache-1.1"
KEYWORDS="~x86"
IUSE="ssl"

S="${WORKDIR}/${MY_P}"

SVN_REPOS_LOC="${SVN_REPOS_LOC:-/var/svn}"

APACHE2_MOD_FILE="mod_dav_svn"
APACHE2_MOD_CONF="47_${APACHE2_MOD_FILE}"
APACHE2_MOD_DEFINE="SVN"

DOCFILES=""

DEPEND=">=dev-util/subversion-1.1.0-r1"

need_apache2

src_unpack() {
	cd ${WORKDIR}
	unpack ${MY_P}.tar.bz2 || die "unpacking failed for some strange reason"

	cd ${S}
	export WANT_AUTOCONF_2_5=1
	autoconf
	(cd apr; autoconf)
	(cd apr-util; autoconf)
	sed -i -e 's,\(subversion/svnversion/svnversion\)\(>.*svn-revision.txt\),echo "external" \2,' Makefile.in
}

src_compile() {
	cd ${S}

	econf \
		`use_with ssl` \
		--with-apxs=${APXS2} \
		--with-apr=/usr \
		--with-apr-util=/usr \
		--with-neon=/usr \
		--without-swig \
		--without-python \
		--disable-experimental-libtool \
		--disable-mod-activation || die "configuration failed"

	# build subversion, but do it in a way that is safe for paralel builds
	# Also apparently the included apr does have a libtool that doesn't like
	# -L flags. So not specifying it at all when not building apache modules
	# and only specify it for internal parts otherwise
	( emake external-all && emake mod_{dav,authz}_svn ) || die
}

src_install() {
	# however, it shall only install the mod_dav_svn (FIXME: what about  mod_authz_svn?)
	make DESTDIR=${D} install-mods-shared || die "Installation of subversion failed"

	if [ -e ${D}/usr/lib/apache2 ]; then
		if has_version '>=net-www/apache-2.0.48-r2'; then
			mv ${D}/usr/lib/apache2/modules ${D}/${APACHE2_MODULESDIR}
			rmdir ${D}/usr/lib/apache2
		else
			mv ${D}/usr/lib/apache2 ${D}/${APACHE2_MODULESDIR}
		fi
	fi

	# do we need them? well, I guess they may be helpful for the enduser anyway
	dodoc tools/xslt/svnindex.css tools/xslt/svnindex.xsl

	# install apache module config
	sed -e "s:@SVN_REPOS_LOC@:${SVN_REPOS_LOC}:" ${FILESDIR}/${APACHE2_MOD_CONF}.conf \
		> ${APACHE2_MOD_CONF}.conf

	insinto ${APACHE2_MODULES_CONFDIR}
	doins ${APACHE2_MOD_CONF}.conf

	einfo
	einfo "Configuration file installed as ${APACHE2_MODULES_CONFDIR}/${APACHE2_MOD_CONF}.conf"
	einfo "You may want to edit it before turning the module on in /etc/conf.d/apache2"
	einfo
}

# vim:ts=4
