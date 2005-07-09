# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/webalizer/webalizer-2.01.10-r10.ebuild,v 1.1 2005/07/09 04:43:37 smithj Exp $

# uses webapps to create directories with right permissions
# probably slight overkil but works well
inherit eutils depend.apache webapp

MY_PV=${PV/.10/-10}
MY_P=${PN}-${MY_PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Webserver log file analyzer"
HOMEPAGE="http://www.mrunix.net/webalizer/"
SRC_URI="ftp://ftp.mrunix.net/pub/webalizer/${MY_P}-src.tar.bz2
	geoip? ( http://sysd.org/proj/geolizer_${MY_PV}-patch.20040216.tar.bz2 )"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~ppc64"
IUSE="apache2 geoip nls"

DEPEND="=sys-libs/db-4.1*
	>=sys-libs/zlib-1.1.4
	>=media-libs/libpng-1.2
	>=media-libs/gd-1.8.3
	geoip? ( dev-libs/geoip )"

pkg_setup() {
	webapp_pkg_setup

	# prevents "undefined reference" errors... see bug #65163
	if ! built_with_use media-libs/gd png; then
		ewarn "media-libs/gd must be built with png for this package"
		ewarn "to function."
		die "recompile gd with USE=\"png\""
	fi

	# USE=nls has no real meaning if LINGUAS isn't set
	if use nls && [ -z "${LINGUAS}" ]; then
		ewarn "you must set LINGUAS in /etc/make.conf"
		ewarn "if you want to USE=nls"
		die "please either set LINGUAS or do not use nls"
	fi
}

src_unpack() {
	unpack ${A} ; cd ${S}

	sed -i -e "s,db_185.h,db.h," configure

	# geoip patch messes up db4.1 patch, so both are dependent on geoip USE
	# flag, even though both of the db patches do the _exact_ same thing
	if use geoip; then
		cd ${WORKDIR}
		epatch ${WORKDIR}/geolizer_${MY_PV}-patch/geolizer.patch || die
		cd ${S}
		epatch ${FILESDIR}/${PN}-db4-with-geoip.patch || die
	else
		epatch ${FILESDIR}/${PN}-readability.patch || die
		epatch ${FILESDIR}/${PN}-db4.patch || die
	fi
}

src_compile() {
	local myconf

	# method of lookup established
	if use geoip; then
		myconf="${myconf} --enable-geoip"
	else
		myconf="${myconf} --enable-dns"
	fi

	# really dirty hack; necessary due to a really gross ./configure
	# basically, it just sets the natural language the program uses
	# unfortunatly, this program only allows for one lang, so only the first
	# entry in LINGUAS is used
	if use nls; then
		local longlang
		longlang="$(grep ^${LINGUAS:0:2} ${FILESDIR}/webalizer-language-list.txt)"
		myconf="${myconf} --with-language=${longlang:3}"
	else
		myconf="${myconf} --with-language=english"
	fi

	# stupid broken configuration file
	autoconf

	econf \
		--with-db=/usr/include/db4.1/ \
		${myconf} || die "econf failed"

	emake || die "make failed"
}

src_install() {
	webapp_src_preinst

	into /usr
	dobin webalizer
	dosym webalizer /usr/bin/webazolver
	doman webalizer.1

	insinto /etc
	doins ${FILESDIR}/${PV}/webalizer.conf
	use apache2 && sed -i -e "s/apache/apache2/g" ${D}/etc/webalizer.conf

	if use apache2; then
		insinto ${APACHE2_MODULES_CONFDIR}
	else
		insinto ${APACHE1_MODULES_CONFDIR}
	fi
	newins ${FILESDIR}/${PV}/apache.webalizer 55_webalizer.conf

	dodoc README* CHANGES Copyright sample.conf
	webapp_hook_script ${FILESDIR}/${PV}/reconfig
	webapp_src_install
}

pkg_postinst(){
	einfo
	einfo "It is suggested that you restart apache before using webalizer"
	einfo
	einfo "Just type webalizer to generate your stats."
	einfo "You can also use cron to generate them e.g. every day."
	einfo "They can be accessed via http://localhost/webalizer"
	einfo

	if [ ${#LINGUAS} -gt 2 ] && use nls; then
		ewarn
		ewarn "You have more than one language in LINGUAS"
		ewarn "Due to the limitations of this packge, it was built"
		ewarn "only with ${LINGUAS:0:2} support. If this is not what"
		ewarn "you intended, please place the language you desire"
		ewarn "_first_ in the list of LINGUAS in /etc/make.conf"
		ewarn
	fi

	webapp_pkg_postinst
}
