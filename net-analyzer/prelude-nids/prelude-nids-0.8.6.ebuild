# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/prelude-nids/prelude-nids-0.8.6.ebuild,v 1.11 2005/06/20 21:00:38 vanquirius Exp $

inherit flag-o-matic

DESCRIPTION="Prelude-IDS NIDS"
HOMEPAGE="http://www.prelude-ids.org/"
SRC_URI="http://www.prelude-ids.org/download/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ppc"
IUSE="doc debug"

DEPEND="virtual/libc
	!dev-libs/libprelude-cvs
	!net-analyzer/prelude-nids-cvs
	<dev-libs/libprelude-0.9.0_rc1
	doc? ( dev-util/gtk-doc )"

src_compile() {
	local myconf

	use doc && myconf="${myconf} --enable-gtk-doc" || myconf="${myconf} --enable-gtk-doc=no"
	use debug && append-flags -O -ggdb

	econf ${myconf} || die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	insinto /etc/init.d
	insopts -m 755
	newins ${FILESDIR}/gentoo.init prelude-nids
	insinto /etc/conf.d
	insopts -m 644
	newins ${FILESDIR}/gentoo.conf prelude-nids
	into /usr/libexec/prelude
	insopts -m 755
	doins plugins/detects/snortrules/ruleset/convert_ruleset
	into /usr/share/prelude/ruleset
	mv ${D}/etc/prelude-nids/ruleset ${D}/usr/share/prelude/ruleset/nids
	dosym /usr/share/prelude/ruleset/nids /etc/prelude-nids/ruleset
}

pkg_postinst(){
	ewarn "Please note that net-analyzer/prelude-nids is no longer"
	ewarn "maintained as net-analyzer/snort replaces it in the developing"
	ewarn "branch. If you want to use unstable prelude, please unmerge"
	ewarn "net-analyzer/prelude-nids to avoid undesired downgrades of"
	ewarn "dev-libs/libprelude."
}
