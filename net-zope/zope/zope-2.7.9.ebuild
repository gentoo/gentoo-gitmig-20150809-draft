# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zope/zope-2.7.9.ebuild,v 1.6 2006/09/03 15:39:30 tcort Exp $

inherit eutils

DESCRIPTION="Zope is a web application platform used for building high-performance, dynamic web sites"
HOMEPAGE="http://www.zope.org"
HOTFIXES_URI="http://www.zope.org/Products/Zope/Hotfix-2006-08-21/Hotfix-20060821/Hotfix_20060821.tar.gz"
SRC_URI="http://www.zope.org/Products/Zope/Zope-${PV}/Zope-${PV}-final.tgz
			${HOTFIXES_URI}"

LICENSE="ZPL"
SLOT="${PV}"
KEYWORDS="alpha amd64 ppc sparc x86"
IUSE="unicode"

RDEPEND="=dev-lang/python-2.3*"
python='python2.3'

DEPEND="${RDEPEND}
virtual/libc
>=sys-apps/sed-4.0.5"

S="${WORKDIR}/Zope-${PV}-final"
ZUID=zope
ZGID=zope
ZS_DIR=${ROOT%/}/usr/lib
ZSERVDIR=${ZS_DIR}/${P}

# Narrow the scope of ownership/permissions.
# Security plan:
# * ZUID is the superuser for all zope instances.
# * ZGID is for a single instance's administration.
# * Other' should not have any access to ${ZSERVDIR},
#   because they can work through the Zope web interface.
#   This should protect our code/data better.
#
# UPDATE: ${ZSERVDIR} is a lib directory and should be world readable
# like e.g /usr/lib/python we do not store any user data there,
# currently removed all custom permission stuff, for ${ZSERVDIR}

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_compile() {
	./configure --ignore-largefile --prefix=. --with-python=/usr/bin/python2.3 || die "Failed to configure."
	emake || die "Failed to compile."
}

src_install() {
	dodoc README.txt
	dodoc doc/*.txt
	docinto PLATFORMS ; dodoc doc/PLATFORMS/*

	# Patched StructuredText will accept source text formatted in utf-8 encoding, 
	# apply all formattings and output utf-8 encoded text.
	# if you want to use this option you need to set your
	# system python encoding to utf-8 (create the file sitecustomize.py inside
	# your site-packages, add the following lines
	# 	import sys
	# 	sys.setdefaultencoding('utf-8')
	# If this is a problem, let me know right away. --batlogg@gentoo.org
	# I wondering if we need a USE flag for this and wheter we can set the
	# sys.encoding automtically
	# so i defined a use flag

	if use unicode; then
		einfo "Patching structured text"
		einfo "make sure you have set the system python encoding to utf-8"
		einfo "create the file sitecustomize.py inside your site-packages"
	 	einfo "import sys"
		einfo "sys.setdefaultencoding('utf8')"
		cd ${S}/lib/python/StructuredText/
		epatch ${FILESDIR}/2.7.8/i18n-1.0.0.patch
		epause 15
		cd ${S}
	fi

	make install PREFIX=${D}${ZSERVDIR}
	rm -rf ${D}${ZSERVDIR}/doc
	dosym ../../share/doc/${PF} ${ZSERVDIR}/doc
	# copy the init script skeleton to skel directory of our installation
	skel=${D}${ZSERVDIR}/skel
	# <radek@gentoo.org> from 2.7.4 release i think that we can use the same
	# file for every one, and not separate it by PV
	cp ${FILESDIR}/zope.initd ${skel}/zope.initd

	# hotfixes to be applied
	cp -a ${WORKDIR}/Hotfix_20060821/ ${D}${ZSERVDIR}/lib/python/Products/
}

pkg_postinst() {
	# create the zope user and group for backward compatibility
	enewgroup ${ZGID} 261
	usermod -g ${ZGID} ${ZUID} 2>&1 >/dev/null || \
	enewuser ${ZUID} 261 -1 /var/lib/zope  ${ZGID}

	einfo "Be warned that you need at least one zope instance to run zope."
	einfo "Please emerge zope-config for futher instance management."
}

pkg_prerm() {

	#need to remove this symlink because portage keeps links to
	#existing targets

	rm ${ZSERVDIR}/bin/python
}
