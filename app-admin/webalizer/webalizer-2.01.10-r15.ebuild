# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/webalizer/webalizer-2.01.10-r15.ebuild,v 1.14 2010/10/28 03:35:18 sping Exp $

EAPI="2"

# uses webapp.eclass to create directories with right permissions
# probably slight overkill but works well
inherit eutils webapp db-use autotools

SLOT="0"
WEBAPP_MANUAL_SLOT="yes"

MY_PV=${PV/.10/-10}
MY_P=${PN}-${MY_PV}
S="${WORKDIR}"/${MY_P}
XTENDED_VER="RB17"
XTENDED_URL="rb17"
DESCRIPTION="Webserver log file analyzer"
HOMEPAGE="http://www.mrunix.net/webalizer/"
SRC_URI="ftp://ftp.mrunix.net/pub/webalizer/old/${MY_P}-src.tar.bz2
	geoip? ( http://sysd.org/proj/geolizer_${MY_PV}-patch.20050520.tar.bz2 )
	xtended? (
	http://www.irc.unizh.ch/users/pfrei/webalizer/${XTENDED_URL}/${PN}-${MY_PV}-${XTENDED_VER}-patch.tar.gz )
	mirror://gentoo/${PN}.conf.gz
"

LICENSE="GPL-2"
KEYWORDS="alpha amd64 hppa ppc ppc64 sparc x86"
IUSE="apache2 geoip nls xtended"

DEPEND=">=sys-libs/db-4.2
	>=sys-libs/zlib-1.1.4
	>=media-libs/libpng-1.2
	>=media-libs/gd-1.8.3[png]
	geoip? ( dev-libs/geoip )"
RDEPEND="${DEPEND}"

pkg_setup() {
	webapp_pkg_setup

	# USE=nls has no real meaning if LINGUAS isn't set
	if use nls && [ -z "${LINGUAS}" ]; then
		ewarn "you must set LINGUAS in /etc/make.conf"
		ewarn "if you want to USE=nls"
		die "please either set LINGUAS or do not use nls"
	fi
}

src_prepare() {
	if use geoip; then
		epatch "${WORKDIR}"/geolizer_${MY_PV}-patch/geolizer.patch \
				"${FILESDIR}"/geolizer-2.01.10_p20070115-strip.patch
		use xtended && elog "Xtended doesn't work with geolizer, skipping"
	else
		epatch "${FILESDIR}"/${PN}-db4.2.patch || die
		if use xtended; then
			epatch "${WORKDIR}"/${PN}-${MY_PV}-${XTENDED_VER}-patch || die
		fi
	fi

	# bug 121816: prevent truncated useragent fields
	sed -i -e 's:^#define MAXAGENT 64:#define MAXAGENT 128:' webalizer.h

	# stupid broken configuration file
	eautoreconf
}

src_configure() {
	local myconf=" --enable-dns \
		--with-db=$(db_includedir) \
		--with-dblib=$(db_libname)"
	use geoip && myconf="${myconf} --enable-geoip"

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

	econf ${myconf} || die "econf failed"
}

src_install() {
	webapp_src_preinst

	into /usr
	dobin webalizer
	dosym webalizer /usr/bin/webazolver
	doman webalizer.1

	insinto /etc
	doins "${WORKDIR}"/${PN}.conf
	use apache2 && sed -i -e "s/apache/apache2/g" "${D}"/etc/webalizer.conf

	dodoc *README* CHANGES Copyright sample.conf "${FILESDIR}"/apache.webalizer
	webapp_src_install
}

pkg_postinst(){
	elog
	elog "It is suggested that you restart apache before using webalizer"
	elog "You may want to review /etc/webalizer.conf and ensure that"
	elog "OutputDir is set correctly"
	elog
	elog "Then just type webalizer to generate your stats."
	elog "You can also use cron to generate them e.g. every day."
	elog "They can be accessed via http://localhost/webalizer"
	elog
	elog "A sample Apache config file has been installed into"
	elog "/usr/share/doc/${PF}/apache.webalizer"
	elog "Please edit and install it as necessary"
	elog

	if [ ${#LINGUAS} -gt 2 ] && use nls; then
		ewarn
		ewarn "You have more than one language in LINGUAS"
		ewarn "Due to the limitations of this packge, it was built"
		ewarn "only with ${LINGUAS:0:2} support. If this is not what"
		ewarn "you intended, please place the language you desire"
		ewarn "_first_ in the list of LINGUAS in /etc/make.conf"
		ewarn
	fi

	if use xtended; then
		elog "Read http://www.irc.unizh.ch/users/pfrei/webalizer/${XTENDED_URL}/INSTALL"
		elog "if you are switching from stock webalizer to xtended"
	fi

	webapp_pkg_postinst
}
