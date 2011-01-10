# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/prelude-lml/prelude-lml-0.9.1.ebuild,v 1.9 2011/01/10 20:56:09 tomka Exp $

inherit flag-o-matic

DESCRIPTION="Prelude-IDS Log Monitoring Lackey"
HOMEPAGE="http://www.prelude-ids.org/"
SRC_URI="http://www.prelude-ids.org/download/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc ~x86"
IUSE="doc debug"

RDEPEND="!dev-libs/libprelude-cvs
	!app-admin/prelude-lml-cvs
	>=dev-libs/libprelude-0.9.0
	dev-libs/libpcre"

DEPEND="${RDEPEND}
	doc? ( dev-util/gtk-doc )"

src_compile() {
	local myconf

	use doc \
		&& myconf="${myconf} --enable-gtk-doc" \
		|| myconf="${myconf} --enable-gtk-doc=no"
	use debug && append-flags -O -ggdb

	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	newinitd "${FILESDIR}"/gentoo.init prelude-lml
	newconfd "${FILESDIR}"/gentoo.conf prelude-lml
	into /usr/share/prelude/ruleset
	mv "${D}"/etc/prelude-lml/ruleset "${D}"/usr/share/prelude/ruleset/lml
	dosym /usr/share/prelude/ruleset/lml /etc/prelude-lml/ruleset
}
