# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/nfs-utils/nfs-utils-1.0.10.ebuild,v 1.11 2007/03/21 15:51:37 wolf31o2 Exp $

inherit eutils flag-o-matic multilib

DESCRIPTION="NFS client and server daemons"
HOMEPAGE="http://nfs.sourceforge.net/"
SRC_URI="mirror://sourceforge/nfs/${P}.tar.gz
	http://www.citi.umich.edu/projects/nfsv4/linux/nfs-utils-patches/${PV}-1/nfs-utils-${PV}-CITI_NFS4_ALL-1.dif"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86"
IUSE="nonfsv4 tcpd kerberos"

# kth-krb doesn't provide the right include
# files, and nfs-utils doesn't build against heimdal either, 
# so don't depend on virtual/krb.
# (04 Feb 2005 agriffis)
RDEPEND="tcpd? ( sys-apps/tcp-wrappers )
	>=net-nds/portmap-5b-r6
	!nonfsv4? (
		>=dev-libs/libevent-1.0b
		>=net-libs/libnfsidmap-0.16
	)
	kerberos? (
		net-libs/librpcsecgss
		app-crypt/mit-krb5
	)"
DEPEND="${RDEPEND}
	>=sys-apps/portage-2.0.51"

src_unpack() {
	unpack ${P}.tar.gz
	cd "${S}"
	epatch "${DISTDIR}"/nfs-utils-${PV}-CITI_NFS4_ALL-1.dif
	epatch "${FILESDIR}"/${PN}-1.0.7-man-pages.patch #107991
	epatch "${FILESDIR}"/${P}-uts-release.patch
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
	make DESTDIR="${D}" install || die

	# Don't overwrite existing xtab/etab, install the original
	# versions somewhere safe...  more info in pkg_postinst
	dodir /usr/lib/nfs
	keepdir /var/lib/nfs/{sm,sm.bak}
	mv "${D}"/var/lib/nfs/* "${D}"/usr/lib/nfs
	keepdir /var/lib/nfs

	# Install some client-side binaries in /sbin
	dodir /sbin
	mv "${D}"/usr/sbin/rpc.{lockd,statd} "${D}"/sbin/

	dodoc ChangeLog README
	docinto linux-nfs ; dodoc linux-nfs/*

	insinto /etc
	doins "${FILESDIR}"/exports
	use !nonfsv4 && doins utils/idmapd/idmapd.conf

	doinitd "${FILESDIR}"/nfs "${FILESDIR}"/nfsmount
	newconfd "${FILESDIR}"/nfs.confd nfs

	# uClibc doesn't provide rpcgen like glibc, so lets steal it from nfs-utils
	if ! use elibc_glibc ; then
		dobin tools/rpcgen/rpcgen || die "rpcgen"
		newdoc tools/rpcgen/README README.rpcgen
	fi
}

pkg_preinst() {
	if [[ -s ${ROOT}/etc/exports ]] ; then
		rm -f "${D}"/etc/exports
	fi
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
