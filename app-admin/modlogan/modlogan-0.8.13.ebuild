# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/modlogan/modlogan-0.8.13.ebuild,v 1.5 2004/12/11 15:26:12 kloeri Exp $

MY_FILESDIR="${FILESDIR}/${PV}"
THEMES_VERSION="0.0.7"

DESCRIPTION="Logfile Analyzer"
HOMEPAGE="http://jan.kneschke.de/projects/modlogan/"
SRC_URI="http://jan.kneschke.de/projects/modlogan/download/${P}.tar.gz
	 http://jan.kneschke.de/projects/modlogan/download/modlogan-themes-${THEMES_VERSION}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ia64 ~amd64 ~ppc sparc alpha ~hppa"
IUSE="nls mysql"

RDEPEND="dev-libs/libxml
	dev-libs/libxml2
	media-libs/jpeg
	media-libs/libpng
	>=media-libs/gd-2
	>=dev-libs/libpcre-3.2
	>=net-libs/adns-1.0
	sys-libs/zlib
	app-arch/bzip2
	dev-lang/perl
	X? ( virtual/x11 )
	mysql? ( >=dev-db/mysql-3.23.26 )"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_compile() {
	local myconf

	use mysql \
		&& myconf="--with-mysql=/usr" \
		|| myconf="--without-mysql"

	use nls || myconf="${myconf} --disable-nls"

	econf \
		--enable-plugins \
		--sysconfdir=/etc \
		--libdir=/usr/lib/modlogan \
		--disable-check-dynamic \
		${myconf} || die

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
#		sysconfdir=${D}/etc \
#		libdir=${D}/usr/lib/modlogan || die

	insinto /etc/modlogan

	newins ${MY_FILESDIR}/sample.conf modlogan.conf.sample
	newins ${MY_FILESDIR}/sample.def.conf modlogan.def.conf.sample

	insinto /etc/modlogan
	newins doc/modlogan.css-dist modlogan.css
	doins doc/output.tmpl
	doins doc/modlogan.searchengines
### needs some fixing
#	insinto /etc/httpd
#	newins ${MY_FILESDIR}/modlogan.conf httpd.modlogan
###
	keepdir /var/www/localhost/htdocs/modlogan
	preplib /usr
	dodoc AUTHORS ChangeLog README NEWS TODO
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
