# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/prelink/prelink-20050314.ebuild,v 1.2 2005/05/27 18:01:02 cretin Exp $

inherit eutils

DESCRIPTION="Modifies executables so runtime libraries load faster"
HOMEPAGE="ftp://people.redhat.com/jakub/prelink"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://dev.gentoo.org/~azarah/prelink/${P}.tar.bz2
	ftp://people.redhat.com/jakub/prelink/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ppc alpha"
IUSE=""

DEPEND=">=dev-libs/elfutils-0.100
	!dev-libs/libelf
	>=sys-libs/glibc-2.3.2-r9
	>=sys-devel/binutils-2.13.90.0.10"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-20040707-init.patch
	epatch ${FILESDIR}/${P}-amd64-gcc4.patch

	# Build our /etc/env.d/60prelink
	cat > "${S}/60prelink" <<-EOF
		$(
			# Need to initialize PRELINK_PATH_MASK so that we can
			# just add ':${x}' below.
			PRELINK_PATH_MASK="/lib/modules"
			# Ok, now add the rest
			for x in /usr/$(get_libdir)/locale \
			         /usr/$(get_libdir)/wine \
			         /usr/$(get_libdir)/valgrind \
			         "*.la" "*.png" "*.py" "*.pl" "*.pm" \
			         "*.sh" "*.xml" "*.xslt" "*.a" "*.js" ; do
				PRELINK_PATH_MASK="${PRELINK_PATH_MASK}:${x}"
			done
			# Now add it quoted
			echo PRELINK_PATH_MASK="\"${PRELINK_PATH_MASK}\""
		)
		PRELINK_PATH=""
	EOF
}

src_compile() {
	econf || die "Configure failed"
	emake || die "Make Failed"
}

src_install() {
	einstall || die "Install Failed"

	doenvd ${S}/60prelink

	dodoc INSTALL TODO ChangeLog THANKS COPYING README AUTHORS NEWS
}

pkg_postinst() {
	echo
	einfo "You may wish to read the Gentoo Linux Prelink Guide, which can be"
	einfo "found online at:"
	einfo "    http://www.gentoo.org/doc/en/prelink-howto.xml"
	echo
}
