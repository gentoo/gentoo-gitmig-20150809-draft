# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/nfs-utils/nfs-utils-1.0.7-r2.ebuild,v 1.7 2007/03/25 12:28:59 vapier Exp $

inherit eutils flag-o-matic

DESCRIPTION="NFS client and server daemons"
HOMEPAGE="http://nfs.sourceforge.net/"
SRC_URI="mirror://sourceforge/nfs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE="nonfsv4 tcpd kerberos"

# kth-krb doesn't provide the right include
# files, and nfs-utils doesn't build against heimdal either, 
# so don't depend on virtual/krb.
# (04 Feb 2005 agriffis)
RDEPEND="tcpd? ( sys-apps/tcp-wrappers )
	>=net-nds/portmap-5b-r6
	!nonfsv4? (
		>=dev-libs/libevent-1.0b
		>=net-libs/libnfsidmap-0.9
	)
	kerberos? ( app-crypt/mit-krb5 )"
DEPEND="${RDEPEND}
	>=sys-apps/portage-2.0.51"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-gcc4.patch #88421
	epatch "${FILESDIR}"/${P}-man-pages.patch #107991
	epatch "${FILESDIR}"/${P}-no-stripping.patch

	# getrpcbynumber_r is not in the SuSv3 spec. disable it for uClibc
	epatch "${FILESDIR}"/nfs-utils-1.0.6-uclibc.patch

	# since the usn36 patch is now integrated (at least the parts we care about)
	# into 1.0.7, we need to re-apply the rquoted patch (04 Feb 2005 agriffis)
	epatch "${FILESDIR}"/nfs-utils-0.3.3-rquotad-overflow.patch

	sed -i 's:@mandir@:$(install_prefix)@mandir@:' config.mk.in
}

src_compile() {
	econf \
		--mandir=/usr/share/man \
		--with-statedir=/var/lib/nfs \
		--disable-rquotad \
		--enable-nfsv3 \
		--enable-secure-statd \
		$(use_enable !nonfsv4 nfsv4) \
		$(use_enable kerberos gss) \
		|| die "Configure failed"

	if ! use tcpd ; then
		sed -i "s:\(-lwrap\|-DHAVE_TCP_WRAPPER\)::" config.mk
	fi

	# parallel make fails for depend target
	emake -j1 depend || die "failed to make depend"
	emake || die "Failed to compile"
}

src_install() {
	make install_prefix="${D}" install || die

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
	use kerberos && newins support/gssapi/SAMPLE_gssapi_mech.conf

	doinitd "${FILESDIR}"/nfs "${FILESDIR}"/nfsmount
	newconfd "${FILESDIR}"/nfs.confd.old nfs

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
	for f in "${ROOT}"/usr/lib/nfs/*; do
		[[ -f ${ROOT}/var/lib/nfs/${f##*/} ]] && continue
		einfo "Copying default ${f##*/} from /usr/lib/nfs to /var/lib/nfs"
		cp -pPR ${f} "${ROOT}"/var/lib/nfs/
	done
}
