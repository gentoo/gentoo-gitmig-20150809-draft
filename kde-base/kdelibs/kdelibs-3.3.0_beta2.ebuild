# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdelibs/kdelibs-3.3.0_beta2.ebuild,v 1.2 2004/07/23 19:18:11 mr_bones_ Exp $

inherit kde eutils
set-kdedir 3.3

MY_PV=3.2.92
S=${WORKDIR}/${PN}-${MY_PV}

DESCRIPTION="KDE libraries needed by all kde programs"
HOMEPAGE="http//www.kde.org/"
SRC_URI="mirror://kde/unstable/${MY_PV}/src/${PN}-${MY_PV}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
SLOT="3.3"
KEYWORDS="~x86 ~amd64"
IUSE="alsa cups ipv6 ssl doc ldap arts"

# kde.eclass has kdelibs in DEPEND, and we can't have that in here.
# so we recreate the entire DEPEND from scratch.
DEPEND=">=sys-devel/autoconf-2.58
	>=sys-devel/automake-1.8
	>=app-arch/bzip2
	>=dev-libs/libxslt-1.1.4
	>=dev-libs/libxml2-2.6.6
	>=dev-libs/libpcre-4.2
	ssl? ( >=dev-libs/openssl-0.9.7d )
	alsa? ( media-libs/alsa-lib virtual/alsa )
	arts? ( ~kde-base/arts-1.3.0_beta2 )
	cups? ( >=net-print/cups-1.1.19 )
	ldap? ( >=net-nds/openldap-2.1.26 )
	media-libs/tiff
	>=app-admin/fam-2.7.0
	virtual/ghostscript
	media-libs/libart_lgpl
	sys-devel/gettext
	>=x11-libs/qt-3.3.2"
RDEPEND="${DEPEND}
	app-text/sgml-common
	cups? ( net-print/cups )
	doc? ( app-doc/doxygen )
	dev-lang/python"

src_unpack() {
	kde_src_unpack
}

src_compile() {
	kde_src_compile myconf

	myconf="$myconf --with-distribution=Gentoo --enable-libfam --enable-dnotify"
	myconf="$myconf `use_with alsa` `use_enable cups` `use_with arts`"

	use ipv6	|| myconf="$myconf --with-ipv6-lookup=no"
	use ssl		&& myconf="$myconf --with-ssl-dir=/usr"	|| myconf="$myconf --without-ssl"
	use alsa	&& myconf="$myconf --with-alsa" || myconf="$myconf --without-alsa"
	use cups	&& myconf="$myconf --enable-cups" || myconf="$myconf --disable-cups"

	use x86 && myconf="$myconf --enable-fast-malloc=full"

	kde_src_compile configure make

	use doc && make apidox
}

src_install() {
	kde_src_install
	dohtml *.html

	if use doc ; then
		einfo "Copying API documentation..."
		dodir ${KDEDIR}/share/doc/HTML/en/kdelibs-apidocs
		cp -r ${S}/apidocs/* ${D}/$KDEDIR/share/doc/HTML/en/kdelibs-apidocs
	else
		rm -r ${D}/$KDEDIR/share/doc/HTML/en/kdelibs-apidocs
	fi

	# needed to fix lib64 issues on amd64, see bug #45669
	use amd64 && ln -s ${KDEDIR}/lib ${D}/${KDEDIR}/lib64


	if ! use arts ; then

		dodir /etc/env.d

		echo "PATH=${PREFIX}/bin
ROOTPATH=${PREFIX}/sbin:${PREFIX}/bin
LDPATH=${PREFIX}/lib
CONFIG_PROTECT=${PREFIX}/share/config" > ${D}/etc/env.d/47kdepaths-3.3.0 # number goes down with version upgrade

		echo "KDEDIR=$PREFIX" > ${D}/etc/env.d/58kdedir-3.3.0 # number goes up with version upgrade

	fi

}

pkg_postinst() {
	if use doc ; then
		rm $KDEDIR/share/doc/HTML/en/kdelibs-apidocs/common
		ln -sf $KDEDIR/share/doc/HTML/en/common \
			$KDEDIR/share/doc/HTML/en/kdelibs-apidocs/common
	fi
}
