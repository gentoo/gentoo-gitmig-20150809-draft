# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/modlogan/modlogan-0.8.10-r1.ebuild,v 1.1 2003/12/18 00:54:03 stkn Exp $

IUSE="nls mysql X"

THEMES_VERSION="0.0.5"

DESCRIPTION="Logfile Analyzer"
SRC_URI="http://jan.kneschke.de/projects/modlogan/download/${P}.tar.gz
	 http://jan.kneschke.de/projects/modlogan/download/modlogan-themes-${THEMES_VERSION}.tar.gz
	 http://www.kneschke.de/projekte/modlogan/download/gd-1.8.1.tar.gz"

HOMEPAGE="http://jan.kneschke.de/projects/modlogan/"

MY_FILESDIR="${FILESDIR}/${PV%.*}"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ia64 ~amd64 ~ppc ~sparc ~alpha ~hppa ~mips ~arm"

DEPEND="dev-libs/libxml
	dev-libs/libxml2
	media-libs/jpeg
	media-libs/libpng
	=media-libs/freetype-1.3*
	>=dev-libs/libpcre-3.2
	>=net-libs/adns-1.0
	X? ( virtual/x11 )
	mysql? ( >=dev-db/mysql-3.23.26 )"

RDEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	local myconf

	use X \
		&& myconf="${myconf} --with-x" \
		|| myconf="${myconf} --without-x"

	cd ${S}/../gd-1.8.1
	export CFLAGS="$CFLAGS -I/usr/include/freetype"

	./configure ${myconf} || die
	make || die

	cp .libs/libgd.so.0.0.0 libgd.so.0.0.0
	ln -s libgd.so.0.0.0 libgd.so

	use mysql \
		 && myconf="--with-mysql=/usr" \
		 || myconf="--without-mysql"

	use nls || myconf="${myconf} --disable-nls"

	cd ${S}
	econf \
		--enable-plugins \
		--sysconfdir=/etc/modlogan \
		--libdir=/usr/lib/modlogan \
		--with-gd=${WORKDIR}/gd-1.8.1/ \
		--disable-check-dynamic \
		${myconf} || die

	make || die
}

src_install() {
	cd ${S}/../gd-1.8.1
	into /usr
	dolib libgd.so.0.0.0

	cd ${S}
	einstall \
		sysconfdir=${D}/etc/modlogan \
		libdir=${D}/usr/lib/modlogan || die

	insinto /etc/modlogan
	newins ${MY_FILESDIR}/sample.conf modlogan.conf.sample
	newins ${MY_FILESDIR}/sample.def.conf modlogan.def.conf.sample
	insinto /etc/modlogan/modlogan
	newins doc/modlogan.css-dist modlogan.css
	doins doc/output.tmpl
	doins doc/modlogan.searchengines
### needs some fixing
#	insinto /etc/httpd
#	newins ${MY_FILESDIR}/modlogan.conf httpd.modlogan
###
	keepdir /var/www/localhost/htdocs/modlogan
	preplib /usr
	dodoc AUTHORS COPYING ChangeLog README NEWS TODO
	dodoc doc/*.txt doc/*.conf doc/*-dist doc/glosar doc/stats
	dohtml -r html

	# install themes
	cd ${S}/../modlogan-themes-${THEMES_VERSION}
	dodir /usr/share/modlogan/themes
	for i in `ls -1`; do
		einfo "installing theme $i"
		cp -Rf $i ${D}/usr/share/modlogan/themes/
	done
}

pkg_postinst() {
	if [ ! -a ${ROOT}etc/modlogan/modlogan.conf ]
	then
		cd ${ROOT}/etc/modlogan
		sed -e "s:##HOST##:${HOSTNAME}:g" \
			-e "s:##HOST2##:${HOSTNAME/./\\.}:g" \
		modlogan.conf.sample > modlogan.conf
		rm modlogan.conf.sample
	fi

	if [ ! -a ${ROOT}etc/modlogan/modlogan.def.conf ]
	then
		cd ${ROOT}/etc/modlogan
		sed -e "s:##HOST##:${HOSTNAME}:g" \
			-e "s:##HOST2##:${HOSTNAME/./\\.}:g" \
		modlogan.def.conf.sample > modlogan.def.conf
		rm modlogan.def.conf.sample
	fi
}
