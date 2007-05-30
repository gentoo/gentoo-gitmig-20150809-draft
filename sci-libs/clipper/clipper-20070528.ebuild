# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/clipper/clipper-20070528.ebuild,v 1.2 2007/05/30 22:00:27 dberkholz Exp $

inherit autotools

DESCRIPTION="Aset of object-oriented libraries for the organisation of crystallographic data and the performance of crystallographic computation"
HOMEPAGE="http://www.ysbl.york.ac.uk/~cowtan/clipper/clipper.html"
#SRC_URI="http://www.ysbl.york.ac.uk/~cowtan/clipper/clipper20ac.latest.tar.gz"
SRC_URI="http://dev.gentoo.org/~dberkholz/distfiles/clipper20ac.latest-${PV}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
RDEPEND="sci-chemistry/ccp4"
DEPEND="${RDEPEND}"
S="${WORKDIR}"

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}"/${PV}-as-needed.patch

	# Slot libraries with a '-2' suffix so we don't overlap with ccp4
	ebegin "versioning libraries with -2 suffix"
		find . -name Makefile.am \
			| xargs sed -i \
				-e "s~\(lib[[:alnum:]_]*\)_la~\1_2_la~g" \
				-e "s~\(lib[[:alnum:]-]*\).la~\1-2.la~g" \
				-e "s~\(-lclipper[[:alnum:]-]*\)~\1-2~g" \
				|| die "sed to version libs with -2 failed"
	eend $?

	AT_M4DIR="config" eautoreconf
}

src_compile() {
	# Slot programs with a '-2' suffix
	econf \
		--enable-contrib \
		--enable-phs \
		--enable-mmdb \
		--enable-mmdbold \
		--enable-minimol \
		--enable-cif \
		--enable-ccp4 \
		--enable-cns \
		--with-mmdb=/usr \
		--program-suffix=-2 \
		|| die "econf failed"
	emake || die "emake failed"
}
src_install() {
	# Slot includes with a '-2' suffix
	emake \
		DESTDIR="${D}" \
		pkgincludedir=/usr/include/clipper-2 \
		install \
		|| die "emake install failed"

	# Use '-2' suffix in headers
	ebegin "changing headers to use -2 suffix"
	grep 'include.*clipper' -rl "${D}" \
		| xargs sed -i \
			-e "s~\(include.*clipper\)/~\1-2/~g" \
			|| die "sed to find -2 slotted headers failed"
	eend $?
}
