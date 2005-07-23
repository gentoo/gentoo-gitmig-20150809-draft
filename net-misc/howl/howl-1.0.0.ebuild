# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/howl/howl-1.0.0.ebuild,v 1.4 2005/07/23 21:55:23 compnerd Exp $

inherit eutils flag-o-matic

DESCRIPTION="cross-platform implementation of the Zeroconf networking standard"
HOMEPAGE="http://www.porchdogsoft.com/products/howl/"
SRC_URI="http://www.porchdogsoft.com/download/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~mips ~ia64 ~ppc ~s390 ~sparc ~x86 ~ppc64 ~ppc-macos"
IUSE=""

DEPEND="virtual/libc"
# sys-devel/automake - needed if we remove the html docs from /usr/share

# sw_log is unprovided (Bug #87436)
RESTRICT="maketest"

src_unpack() {
	unpack ${A}
	cd ${S}
	# patch fixes #84030 (missing linux/types.h include)
	epatch ${FILESDIR}/${PN}-0.9.8-types.patch
}

src_compile() {
	# The following solves compilation using linux26-headers-2.6.8.1-r2 on ia64.
	# It's not relevant for linux-headers-2.4.x or other linux26-headers, but
	# won't hurt anything.  (21 Jan 2005 agriffis)
	[[ $ARCH == ia64 ]] && append-flags -D_ASM_IA64_TYPES_H

	# If we wanted to remove the html docs in /usr/share/howl....
	#einfo "Removing html docs from build process...."
	#sed -e 's/ docs//' < Makefile.am > Makefile.am.new || die "sed failed"
	#mv Makefile.am.new Makefile.am || die "move failed"
	#aclocal || die "aclocal failed"
	#automake || die "automake failed"

	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR=${D} install || die "emake install failed"
	dodoc AUTHORS COPYING ChangeLog INSTALL README TODO
	dohtml -r docs/

	# Install conf files
	insinto /etc/conf.d
	newins ${FILESDIR}/nifd.conf.d nifd
	newins ${FILESDIR}/mDNSResponder.conf.d mDNSResponder

	# Install init scripts
	insinto /etc/init.d
	newins ${FILESDIR}/nifd.init.d nifd
	newins ${FILESDIR}/mDNSResponder.init.d mDNSResponder

	# Fix the perms on the init scripts
	fperms a+x /etc/init.d/nifd /etc/init.d/mDNSResponder

	# howl-0.9.8 introduces a change in library naming,
	# preserve old libraries to not break things
	preserve_old_lib /usr/$(get_libdir)/libhowl-[0-9].[0-9].[0-9].so.[0-9].[0-9].[0-9]
	preserve_old_lib /usr/$(get_libdir)/libmDNSResponder-[0-9].[0-9].[0-9].so.[0-9].[0-9].[0-9]
}

pkg_postinst() {
	# inform user about library changes
	preserve_old_lib_notify /usr/$(get_libdir)/libhowl-[0-9].[0-9].[0-9].so.[0-9].[0-9].[0-9]
	preserve_old_lib_notify /usr/$(get_libdir)/libmDNSResponder-[0-9].[0-9].[0-9].so.[0-9].[0-9].[0-9]

	ewarn
	ewarn "You should run revdep-rebuild to ensure that any applications which"
	ewarn "use howl use the new version."
	ewarn
	ebeep 5
}
