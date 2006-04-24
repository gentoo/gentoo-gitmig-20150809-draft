# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/webalizer/webalizer-2.01.10-r13.ebuild,v 1.2 2006/04/24 15:46:58 rl03 Exp $

# uses webapp.eclass to create directories with right permissions
# probably slight overkill but works well
inherit eutils webapp

SLOT="0"
WEBAPP_MANUAL_SLOT="yes"

MY_PV=${PV/.10/-10}
MY_P=${PN}-${MY_PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Webserver log file analyzer"
HOMEPAGE="http://www.mrunix.net/webalizer/"
SRC_URI="ftp://ftp.mrunix.net/pub/webalizer/${MY_P}-src.tar.bz2
	geoip? ( http://sysd.org/proj/geolizer_${MY_PV}-patch.20050520.tar.bz2 )
	xtended? ( http://www.irc.unizh.ch/users/pfrei/webalizer/rb07/${PN}-${MY_PV}-RB07-patch.tar.gz )
	mirror://gentoo/${PN}-search.patch.gz
	mirror://gentoo/${PN}.conf.gz
"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="apache2 geoip nls search xtended"

DEPEND="!geoip? ( =sys-libs/db-4.2* )
	>=sys-libs/zlib-1.1.4
	>=media-libs/libpng-1.2
	>=media-libs/gd-1.8.3
	geoip? ( dev-libs/geoip )"

pkg_setup() {
	webapp_pkg_setup

	if use search && ! use geoip; then
		einfo "Please enable the geoip USE flag if you wish to use search"
	fi

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

	if use geoip; then
		epatch ${WORKDIR}/geolizer_${MY_PV}-patch/geolizer.patch || die
		if use search; then
			epatch ${WORKDIR}/${PN}-search.patch || die
		fi
		use xtended && einfo "Xtended doesn't work with geolizer, skipping"
	else
		epatch ${FILESDIR}/${PN}-db4.2.patch || die
		epatch ${FILESDIR}/${PN}-readability.patch || die
		if use xtended; then
			epatch ${WORKDIR}/${PN}-${MY_PV}-RB07-patch || die
		fi
	fi

	# bugzy 121816: prevent truncated useragent fields
	sed -i -e 's:^#define MAXAGENT 64:#define MAXAGENT 128:' webalizer.h
}

src_compile() {
	local myconf=" --enable-dns \
		--with-db=/usr/include/db4.2/ \
		--with-dblib=db-4.2"
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

	# stupid broken configuration file
	autoconf

	econf ${myconf} || die "econf failed"

	emake || die "make failed"
}

src_install() {
	webapp_src_preinst

	into /usr
	dobin webalizer
	dosym webalizer /usr/bin/webazolver
	doman webalizer.1

	insinto /etc
	doins ${WORKDIR}/${PN}.conf
	use apache2 && sed -i -e "s/apache/apache2/g" ${D}/etc/webalizer.conf

	dodoc *README* CHANGES Copyright sample.conf ${FILESDIR}/apache.webalizer
	webapp_src_install
}

pkg_postinst(){
	einfo
	einfo "It is suggested that you restart apache before using webalizer"
	einfo "You may want to review /etc/webalizer.conf and ensure that"
	einfo "OutputDir is set correctly"
	einfo
	einfo "Then just type webalizer to generate your stats."
	einfo "You can also use cron to generate them e.g. every day."
	einfo "They can be accessed via http://localhost/webalizer"
	einfo
	einfo "A sample Apache config file has been installed into"
	einfo "/usr/share/doc/${PF}/apache.webalizer"
	einfo "Please edit and install it as necessary"
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

	if use xtended; then
		einfo "Read http://www.irc.unizh.ch/users/pfrei/webalizer/rb07/INSTALL"
		einfo "if you are switching from stock webalizer to xtended"
	fi

	webapp_pkg_postinst
}
