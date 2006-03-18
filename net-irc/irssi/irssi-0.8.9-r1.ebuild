# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/irssi/irssi-0.8.9-r1.ebuild,v 1.14 2006/03/18 19:01:34 swegener Exp $

inherit perl-app eutils flag-o-matic

DESCRIPTION="A modular textUI IRC client with IPv6 support"
HOMEPAGE="http://irssi.org/"
SRC_URI="http://irssi.org/files/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha hppa mips amd64 ia64 ppc64 s390 arm"
IUSE="ipv6 perl ssl socks5"

RDEPEND="!net-irc/irssi-svn
	>=dev-libs/glib-2.2.1
	sys-libs/ncurses
	ssl? ( dev-libs/openssl )
	perl? ( dev-lang/perl )
	socks5? ( >=net-proxy/dante-1.1.13 )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}

	# Ugly hack to work around compression of the html files.
	# Remove this if prepalldocs is changed to avoid gzipping html files.
	cd "${S}" && \
	sed -i \
		-e 's/[^ 	]\+\.html//g' docs/Makefile.in || \
			die "sed doc/Makefile.in failed"

	epatch "${FILESDIR}"/${P}-64bit-exec-fix.patch
	epatch "${FILESDIR}"/${PV}-gcc4-fix.patch
	epatch "${FILESDIR}"/irssi-socks-fix.patch
}

src_compile() {
	# Irssi uses extern inlines and that needs at least -O
	is-flag "-O*" || append-flags -O

	# Note: there is an option to build a GUI for irssi, but according
	# to the website the GUI is no longer developed, so that option is
	# not used here.
	local myconf="--with-glib2 --without-servertest --with-proxy --with-ncurses"

	myconf="${myconf} `use_with perl`"
	myconf="${myconf} `use_enable ipv6`"
	myconf="${myconf} `use_with socks5 socks`"
	if use ssl; then
		myconf="${myconf} --with-openssl-include=/usr --with-openssl-libs=/usr"
	else
		myconf="${myconf} --disable-ssl"
	fi

	econf ${myconf} || die "./configure failed"
	emake || die
}

src_install() {
	if use perl
	then
		for dir in "${S}"/src/perl/{common,irc,textui,ui}
		do
			cd "${dir}"
			perl-app_src_prep
		done
		cd "${S}"
	fi

	make \
		DESTDIR="${D}" \
		docdir=/usr/share/doc/${PF} \
		gnulocaledir="${D}"/usr/share/locale \
		install || die "make install failed"

	use perl && fixlocalpod

	prepalldocs
	dodoc AUTHORS ChangeLog README TODO NEWS || die "dodoc failed"
	dohtml -r ${S}/docs/. || die "dohtml failed"
}
