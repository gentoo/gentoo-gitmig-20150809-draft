# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/nntpswitch/nntpswitch-0.11.ebuild,v 1.1 2004/12/01 21:26:13 swegener Exp $

DESCRIPTION="Load Balancing NNTP Router"
HOMEPAGE="http://www.nntpswitch.org/"
SRC_URI="http://www.nntpswitch.org/download/${P}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE="ldap mysql postgres"

RDEPEND="mysql? ( dev-db/mysql )
	postgres? ( dev-db/postgresql )
	ldap? ( net-nds/openldap )"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}

	sed -i \
		-e "s/-O3/${CFLAGS}/" \
		-e "s:lib/nntpswitch:$(get_libdir)/nntpswitch:" \
		${S}/Makefile
	sed -i \
		-e "s:/usr/local/lib:/usr/$(get_libdir)/nntpswitch:" \
		${S}/nntpswitch.conf.in
	sed -i \
		-e "s:/usr/local/etc/nntpswitch/passwd:/etc/nntpswitch/passwd:" \
		${S}/etc/access.conf
}

src_compile() {
	emake -j1 || die "emake failed"

	if use mysql
	then
		emake -j1 mysql || die "emake mysql failed"
	fi
	if use postgres
	then
		emake -j1 postgres || die "emake postgres failed"
	fi
	if use ldap
	then
		emake -j1 ldap || die "emake ldap failed"
	fi
}

src_install() {
	dodir /usr/sbin /usr/$(get_libdir)/nntpswitch
	make PREFIX="${D}/usr" install || die "make install failed"

	insinto /etc/nntpswitch
	newins nntpswitch.conf-dist nntpswitch.conf || die "newins failed"
	doins etc/{{access,servers}.conf,passwd,overview.fmt} || die "doins failed"

	keepdir /var/lib/nntpswitch || die "keepdir failed"
	dosym /var/lib/nntpswitch/active /etc/nntpswitch/active || die "dosym failed"
	dosym /var/lib/nntpswitch/newsgroups /etc/nntpswitch/newsgroups || die "dosym failed"

	newinitd ${FILESDIR}/nntpswitch.init.d nntpswitch || die "newinitd failed"
}

pkg_postinst() {
	einfo "Please configure nntpswitch using the files in /etc/nntpswitch!"
	einfo
	einfo "After this, you need to generate a nntpswitch-compatible active file,"
	einfo "before you can start nntpswitch for the first time. Use 'updategroups'"
	einfo "to perform this step."
}
