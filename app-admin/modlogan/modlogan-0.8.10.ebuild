# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/modlogan/modlogan-0.8.10.ebuild,v 1.4 2004/02/17 08:39:39 mr_bones_ Exp $

IUSE="nls mysql"

DESCRIPTION="Logfile Analyzer"
SRC_URI="http://jan.kneschke.de/projects/modlogan/download/${P}.tar.gz
	 http://www.kneschke.de/projekte/modlogan/download/gd-1.8.1.tar.gz"
HOMEPAGE="http://jan.kneschke.de/projects/modlogan/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ia64 ~amd64 ~ppc ~sparc ~alpha ~hppa"

DEPEND="virtual/x11
	dev-libs/libxml
	dev-libs/libxml2
	media-libs/jpeg
	media-libs/libpng
	=media-libs/freetype-1.3*
	>=dev-libs/libpcre-3.2
	>=net-libs/adns-1.0
	mysql? ( >=dev-db/mysql-3.23.26 )"

RDEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	cd ${S}/../gd-1.8.1
	export CFLAGS="$CFLAGS -I/usr/include/freetype"

	./configure || die
	make || die

	cp .libs/libgd.so.0.0.0 libgd.so.0.0.0
	ln -s libgd.so.0.0.0 libgd.so

	local myconf
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
	newins ${FILESDIR}/sample.conf modlogan.conf.sample
	newins ${FILESDIR}/sample.def.conf modlogan.def.conf.sample
	doins doc/modlogan.searchengines
	insinto /etc/httpd
	newins ${FILESDIR}/modlogan.conf httpd.modlogan
	dodir /home/httpd/modlogan
	preplib /usr
	dodoc AUTHORS COPYING ChangeLog README NEWS TODO
	dodoc doc/*.txt doc/*.conf doc/glosar doc/stats
	dohtml -r html
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
