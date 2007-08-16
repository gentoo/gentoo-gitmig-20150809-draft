# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/nfs-utils/nfs-utils-1.0.12-r4.ebuild,v 1.1 2007/08/16 23:35:19 vapier Exp $

inherit eutils flag-o-matic multilib

DESCRIPTION="NFS client and server daemons"
HOMEPAGE="http://nfs.sourceforge.net/"
SRC_URI="mirror://sourceforge/nfs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="nonfsv4 tcpd kerberos"

# kth-krb doesn't provide the right include
# files, and nfs-utils doesn't build against heimdal either,
# so don't depend on virtual/krb.
# (04 Feb 2005 agriffis)
DEPEND="tcpd? ( sys-apps/tcp-wrappers )
	>=net-nds/portmap-5b-r6
	!nonfsv4? (
		>=dev-libs/libevent-1.0b
		>=net-libs/libnfsidmap-0.16
	)
	kerberos? (
		net-libs/librpcsecgss
		app-crypt/mit-krb5
	)"

src_unpack() {
	unpack ${P}.tar.gz
	cd "${S}"
	epatch "${FILESDIR}"/${P}-mountd-memleak.patch #172014
	#epatch "${DISTDIR}"/nfs-utils-${PV}-CITI_NFS4_ALL-1.dif
}

src_compile() {
	econf \
		--mandir=/usr/share/man \
		--with-statedir=/var/lib/nfs \
		--disable-rquotad \
		--enable-nfsv3 \
		--enable-secure-statd \
		$(use_with tcpd tcp-wrappers) \
		$(use_enable !nonfsv4 nfsv4) \
		$(use_enable kerberos gss) \
		|| die "Configure failed"

	emake || die "Failed to compile"
}

src_install() {
	emake DESTDIR="${D}" install || die

	# Don't overwrite existing xtab/etab, install the original
	# versions somewhere safe...  more info in pkg_postinst
	dodir /usr/lib/nfs
	keepdir /var/lib/nfs/{sm,sm.bak}
	mv "${D}"/var/lib/nfs/* "${D}"/usr/lib/nfs
	keepdir /var/lib/nfs

	# Install some client-side binaries in /sbin
	dodir /sbin
	mv "${D}"/usr/sbin/rpc.{lockd,statd} "${D}"/sbin/ || die

	dodoc ChangeLog README
	docinto linux-nfs ; dodoc linux-nfs/*

	insinto /etc
	doins "${FILESDIR}"/exports

	local f list=""
	use !nonfsv4 && list="${list} rpc.idmapd"
	use kerberos && list="${list} rpc.gssd"
	for f in nfs nfsmount rpc.statd ${list} ; do
		newinitd "${FILESDIR}"/${f}.initd ${f} || die "doinitd ${f}"
	done
	newconfd "${FILESDIR}"/nfs.confd nfs
	use !nonfsv4 && doins utils/idmapd/idmapd.conf

	# uClibc doesn't provide rpcgen like glibc, so lets steal it from nfs-utils
	if ! use elibc_glibc ; then
		dobin tools/rpcgen/rpcgen || die "rpcgen"
		newdoc tools/rpcgen/README README.rpcgen
	fi
}

pkg_preinst() {
	[[ -s ${ROOT}/etc/exports ]] && rm -f "${D}"/etc/exports
}

pkg_postinst() {
	# Install default xtab and friends if there's none existing.
	# In src_install we put them in /usr/lib/nfs for safe-keeping, but
	# the daemons actually use the files in /var/lib/nfs.  This fixes
	# bug 30486
	local f
	for f in "${ROOT}"/usr/$(get_libdir)/nfs/*; do
		[[ -e ${ROOT}/var/lib/nfs/${f##*/} ]] && continue
		einfo "Copying default ${f##*/} from /usr/$(get_libdir)/nfs to /var/lib/nfs"
		cp -pPR "${f}" "${ROOT}"/var/lib/nfs/
	done
}
