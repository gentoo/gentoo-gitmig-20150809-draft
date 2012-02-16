# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/pavuk/pavuk-0.9.36_pre20120215.ebuild,v 1.1 2012/02/16 09:24:02 pacho Exp $

EAPI=4

S="${WORKDIR}/${PN}"

inherit eutils autotools-utils

DESCRIPTION="Web spider and website mirroring tool"
HOMEPAGE="http://www.pavuk.org/"
SRC_URI="http://dev.gentoo.org/~pacho/maintainer-needed/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="debug gtk javascript hammer ipv6 nls profile ssl"

RDEPEND="virtual/libintl
	gtk? ( x11-libs/gtk+:2 )
	javascript? ( dev-lang/spidermonkey )
	ssl? ( dev-libs/openssl )"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	sys-devel/gettext"

AUTOTOOLS_AUTORECONF=1
AUTOTOOLS_IN_SOURCE_BUILD=1

DOCS=( README CREDITS NEWS AUTHORS BUGS TODO MAILINGLIST wget-pavuk.HOWTO
		ChangeLog wget-pavuk.HOWTO pavuk_authinfo.sample pavukrc.sample
		)
src_prepare() {
	sed -i 's/^\(ACLOCAL_AMFLAGS[[:space:]]*=[[:space:]]*-I[[:space:]]*\)\$(top_srcdir)\//\1/' "${S}/Makefile.am" || die
	sed -i 's/\([[:space:]]C\(PP\)*FLAGS=`\)/true; # \1/' "${S}/configure.in" || die
	autotools-utils_src_prepare
}

src_configure() {
	local myeconfargs=(
			--enable-threads
			--enable-socks
			--enable-utf-8
			$(use_enable gtk)
			$(use_enable gtk gtk2)
			$(use_enable gtk gnome)
			$(use_with gtk x)
			$(use_enable debug debugging)
			$(use_enable debug debug-build)
			# $(use_enable debug debug-features)
			$(use_enable ssl)
			$(use_enable nls)
			$(use_enable ipv6)
			$(use_enable javascript js)
			$(use_enable profile profiling)
	)
	# PCRE support is broken!
	# if use pcre; then
	#	myeconfargs=($myeconfargs --with-regex=pcre)
	# else
		myeconfargs+=( "--with-regex=auto" )
	# fi
	autotools-utils_src_configure
}

src_install() {
	if use gtk; then
		insinto /usr/share/applications
		doins "${S}/pavuk.desktop"
	fi

	doman "${S}/doc/pavuk.1"

	autotools-utils_src_install
}
