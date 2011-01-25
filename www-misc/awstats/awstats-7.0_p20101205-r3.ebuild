# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/awstats/awstats-7.0_p20101205-r3.ebuild,v 1.4 2011/01/25 15:58:51 jer Exp $

EAPI=2

inherit eutils versionator

MY_P=${PN}-${PV%_p*}

DESCRIPTION="AWStats is short for Advanced Web Statistics."
HOMEPAGE="http://awstats.sourceforge.net/"

SRC_URI="http://dev.gentoo.org/~flameeyes/awstats/${P}.tar.gz"

# The following SRC_URI is useful only when fetching for the first time
# after bump; upstream does not bump the version when they change it, so
# we rename it to include the date and upload to our mirrors instead.
#SRC_URI="http://awstats.sourceforge.net/files/${MY_P}.tar.gz -> ${P}.tar.gz"

S=${WORKDIR}/${MY_P}

LICENSE="GPL-2"
KEYWORDS="~alpha amd64 hppa ~ppc ~sparc x86 ~x86-fbsd"
IUSE="geoip ipv6"

SLOT="0"

RDEPEND=">=dev-lang/perl-5.6.1
	virtual/perl-Time-Local
	dev-perl/URI
	geoip? ( dev-perl/Geo-IP )
	ipv6? ( dev-perl/Net-IP dev-perl/Net-DNS )"
DEPEND=""

src_prepare() {
	epatch "${FILESDIR}"/${PN}-6.3-gentoo.diff
	epatch "${FILESDIR}"/${P}-nofollow.patch

	# change default installation directory
	find . -type f -exec sed \
		-e "s#/usr/local/awstats/wwwroot#/usr/share/awstats/wwwroot#g" \
		-i {} + || die "find/sed failed"

	# set default values for directories; use apache log as an example
	sed \
		-e "s|^\(LogFile=\).*$|\1\"/var/log/apache2/access_log\"|" \
		-e "s|^\(SiteDomain=\).*$|\1\"localhost\"|" \
		-e "s|^\(DirIcons=\).*$|\1\"/awstats/icon\"|" \
		-i "${S}"/wwwroot/cgi-bin/awstats.model.conf || die "sed failed"

	# enable plugins

	if use ipv6; then
		sed -e "s|^#\(LoadPlugin=\"ipv6\"\)$|\1|" \
		-i "${S}"/wwwroot/cgi-bin/awstats.model.conf || die "sed failed"
	fi

	if use geoip; then
		sed -e '/LoadPlugin="geoip /aLoadPlugin="geoip GEOIP_STANDARD /usr/share/GeoIP/GeoIP.dat"' \
		-i "${S}"/wwwroot/cgi-bin/awstats.model.conf || die "sed failed"
	fi

	find "${S}" '(' -type f -not -name '*.pl' ')' -exec chmod -x {} + || die
}

src_install() {
	dohtml -r docs/* || die
	dodoc README.TXT || die
	newdoc wwwroot/cgi-bin/plugins/example/example.pm example_plugin.pm
	docinto xslt
	dodoc tools/xslt/* || die

	keepdir /var/lib/awstats

	insinto /etc/awstats
	doins "${S}"/wwwroot/cgi-bin/awstats.model.conf || die

	# remove extra content that we don't want to install
	rm -r "${S}"/wwwroot/cgi-bin/awstats.model.conf \
		"${S}"/wwwroot/classes/src || die

	insinto /usr/share/awstats
	doins -r wwwroot || die
	chmod +x "${D}"/usr/share/awstats/wwwroot/cgi-bin/*.pl

	cd "${S}"/tools
	dobin awstats_buildstaticpages.pl awstats_exportlib.pl \
		awstats_updateall.pl
	newbin logresolvemerge.pl awstats_logresolvemerge.pl
	newbin maillogconvert.pl awstats_maillogconvert.pl
	newbin urlaliasbuilder.pl awstats_urlaliasbuilder.pl

	dosym ../share/awstats/wwwroot/cgi-bin/awstats.pl /usr/bin/awstats.pl || die
}

pkg_postinst() {
	elog "The AWStats-Manual is available either inside"
	elog "the /usr/share/doc/${PF} - folder, or at"
	elog "http://awstats.sourceforge.net/docs/index.html ."
	elog
	elog "Copy the /etc/awstats/awstats.model.conf to"
	elog "/etc/awstats/awstats.<yourdomain>.conf and edit it."
	elog ""
	ewarn "This ebuild does no longer use webapp-config to install"
	ewarn "instead you should point your configuration to the stable"
	ewarn "directory tree in the following path:"
	ewarn "    /usr/share/awstats"
}
