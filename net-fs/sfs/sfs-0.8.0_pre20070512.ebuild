# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/sfs/sfs-0.8.0_pre20070512.ebuild,v 1.2 2007/06/23 22:54:14 dirtyepic Exp $

inherit autotools

DESCRIPTION="Self-certifying File System client and server daemons"
HOMEPAGE="http://www.fs.net/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="ssl"

DEPEND=">=dev-libs/gmp-4.1
	>=net-fs/nfs-utils-0.3.3
	ssl? ( >=dev-libs/openssl-0.9.6 )"
RDEPEND="${DEPEND}
	>=net-nds/portmap-5b-r6"

pkg_setup() {
	# checking for NFS support *seems* like a good idea, but since
	# nfs-utils doesn't do it, sfs won't either

	# add the sfs user and group if necessary
	enewgroup sfs
	enewuser sfs "" "" "" sfs
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	m4 libsfs/Makefile.am.m4 > libsfs/Makefile.am
	m4 svc/Makefile.am.m4 > svc/Makefile.am
	eautoreconf

	sed -i -e 's:\ -Werror::g' configure
}

src_compile() {
	econf \
		$(use_with ssl openssl /usr) \
		--with-gmp=/usr \
		--with-gnuld \
		|| die "econf failed"

	emake
}

src_install() {
	emake DESTDIR=${D} install || die

	insinto /etc/sfs/
	doins ${FILESDIR}/sfsrwsd_config

	dodoc AUTHORS ChangeLog NEWS \
		README README.0.7-upgrade \
		STANDARDS TODO

	doinitd ${FILESDIR}/sfscd \
		${FILESDIR}/sfssd

	dosym /usr/lib/${P}/newaid /usr/bin/newaid
}

pkg_postinst() {
	elog "Execute '/etc/init.d/sfscd start' to start the SFS client,"
	elog "    or 'rc-update add sfscd default' to add it to the"
	elog "    default runlevel."
	elog
	elog "See the SFS documentation for server configuration."
	elog
	elog "Both the client and server require kernel support"
	elog "    for NFS version 3 in order to operate properly."
	elog
}

pkg_config() {
	einfo "Generating SFS host key..."
	sfskey gen -P /etc/sfs/sfs_host_key
}
