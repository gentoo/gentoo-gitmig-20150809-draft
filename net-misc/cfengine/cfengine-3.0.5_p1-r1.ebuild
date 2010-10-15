# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/cfengine/cfengine-3.0.5_p1-r1.ebuild,v 1.2 2010/10/15 20:52:29 idl0r Exp $

EAPI="3"

inherit eutils autotools

MY_PV="${PV//_beta/b}"
MY_PV="${MY_PV/_p/p}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="An automated suite of programs for configuring and maintaining
Unix-like computers"
HOMEPAGE="http://www.cfengine.org/"
SRC_URI="http://www.cfengine.org/tarballs/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="3"
KEYWORDS="~amd64 ~s390 ~x86"

IUSE="examples gd graphviz html ldap libvirt mysql pcre postgres qdbm selinux tests tokyocabinet vim-syntax"

DEPEND=">=sys-libs/db-4
	gd? ( media-libs/gd )
	graphviz? ( media-gfx/graphviz )
	ldap? ( net-nds/openldap )
	libvirt? ( app-emulation/libvirt )
	mysql? ( virtual/mysql )
	pcre? ( dev-libs/libpcre )
	postgres? ( dev-db/postgresql-base )
	selinux? ( sys-libs/libselinux )
	tokyocabinet? ( dev-db/tokyocabinet )
	qdbm? ( dev-db/qdbm )
	!tokyocabinet? ( !qdbm? ( >=sys-libs/db-4 ) )
	>=dev-libs/openssl-0.9.7"
RDEPEND="${DEPEND}"
PDEPEND="vim-syntax? ( app-vim/cfengine-syntax )"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}/${P}-configure.ac.patch"
	epatch "${FILESDIR}/${P}-Makefile.am.patch"
	epatch "${FILESDIR}/${P}-regex.c.patch"
	eautoreconf
}

src_configure() {
	local myconf

	if use mysql || use postgres ; then
		myconf="--with-sql"
	else
		myconf="--without-sql"
	fi

	if ! use qdbm && ! use tokyocabinet; then
		myconf="${myconf} --with-berkeleydb=/usr"
	fi

	# Enforce /var/cfengine for historical compatibility
	econf \
		--docdir=/usr/share/doc/"${PF}" \
		--with-workdir=/var/cfengine \
		${myconf} \
		$(use_with gd) \
		$(use_with graphviz) \
		$(use_with ldap) \
		$(use_with libvirt) \
		$(use_with pcre) \
		$(use_with qdbm) \
		$(use_enable selinux) \
		$(use_with tokyocabinet)

	# Fix Makefile to skip inputs, see below "examples"
	sed -i -e 's/\(SUBDIRS.*\) inputs/\1/' Makefile || die

	# We install documentation through portage
	sed -i -e 's/\(install-data-am.*\) install-docDATA/\1/' Makefile || die

	if use tests; then
		# Fix Makefiles to install tests in correct directory
		for i in file_masters file_operands units ; do
			sed -i -e "s/\(docdir.*\) =.*/\1 = \/usr\/share\/doc\/${PF}\/tests\/${i}/" \
				tests/${i}/Makefile || die
		done
	else
		sed -i -e 's/\(SUBDIRS =\).*/\1/' tests/Makefile || die
	fi
}

src_install() {
	newinitd "${FILESDIR}"/cf-serverd.rc6 cf-servd || die
	newinitd "${FILESDIR}"/cf-monitord.rc6 cf-monitord || die
	newinitd "${FILESDIR}"/cf-execd.rc6 cf-execd || die

	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO INSTALL

	if use examples; then
		docinto examples
		dodoc inputs/*.cf || die
	fi

	# Create cfengine working directory
	dodir /var/cfengine/bin
	fperms 700 /var/cfengine

	# Copy cfagent into the cfengine tree otherwise cfexecd won't
	# find it. Most hosts cache their copy of the cfengine
	# binaries here. This is the default search location for the
	# binaries.
	for bin in know promises agent monitord serverd execd runagent key report; do
		dosym /usr/sbin/cf-$bin /var/cfengine/bin/$bin || die
	done

	if use html; then
		docinto html
		dohtml -r docs/ || die
	fi
}

pkg_postinst() {
	einfo
	einfo "Init scripts for cf-serverd, cf-monitord, and cf-execd are provided."
	einfo
	einfo "To run cfengine out of cron every half hour modify your crontab:"
	einfo "0,30 * * * *    /usr/sbin/cf-execd -F"
	einfo

	elog "If you run cfengine the very first time, you MUST generate the keys for cfengine by running:"
	elog "/usr/sbin/cf-key"
}
