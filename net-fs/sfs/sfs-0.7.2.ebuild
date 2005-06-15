# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/sfs/sfs-0.7.2.ebuild,v 1.13 2005/06/15 20:02:39 griffon26 Exp $

inherit eutils

DESCRIPTION="Self-certifying File System client and server daemons"
HOMEPAGE="http://www.fs.net/"
SRC_URI="http://www.fs.net/sfs/@new-york.lcs.mit.edu,u83s4uk49nt8rmp4uwmt2exvz6d3cavh/pub/sfswww/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="ssl"

DEPEND="virtual/libc
	>=dev-libs/gmp-4.1
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

	# Temporary workaround so that it will compile. Remove this on
	# the next version. See bug #22791
	cd ${S}
	sed -i~ 's/-Werror//g' configure

	epatch ${FILESDIR}/${P}-gcc3.patch.bz2
}

src_compile() {
	econf \
		`use_with ssl openssl /usr` \
		--with-gmp=/usr \
		--with-gnuld \
		--prefix=/ \
		|| die "econf failed"

	# won't parallel build w/o baby-sitting
	emake -j1 || die
}

src_install() {
	einstall prefix=${D}/ || die

	insinto /etc/sfs/
	doins ${FILESDIR}/sfsrwsd_config

	dodoc AUTHORS ChangeLog NEWS \
		README README.0.7-upgrade \
		STANDARDS TODO

	exeinto /etc/init.d/
	doexe ${FILESDIR}/sfscd \
		${FILESDIR}/sfssd

	dosym /lib/${P}/newaid /bin/newaid
}

pkg_postinst() {
	einfo "Execute '/etc/init.d/sfscd start' to start the SFS client,"
	einfo "	 or 'rc-update add sfscd default' to add it to the"
	einfo "	 default runlevel."
	einfo ""
	einfo "See the SFS documentation for server configuration."
	einfo ""
	einfo "Both the client and server require kernel support"
	einfo "	 for NFS version 3 in order to operate properly."
	einfo ""
}

pkg_config() {
	einfo "Generating SFS host key..."
	sfskey gen -P /etc/sfs/sfs_host_key
}
