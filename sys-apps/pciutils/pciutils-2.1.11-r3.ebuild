# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pciutils/pciutils-2.1.11-r3.ebuild,v 1.3 2004/10/19 14:54:28 vapier Exp $

inherit eutils flag-o-matic

STAMP=20041019
DESCRIPTION="Various utilities dealing with the PCI bus"
HOMEPAGE="http://atrey.karlin.mff.cuni.cz/~mj/pciutils.html"
SRC_URI="ftp://atrey.karlin.mff.cuni.cz/pub/linux/pci/${P}.tar.gz
	mirror://gentoo/pci.ids-${STAMP}.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~arm ~mips ~hppa ~amd64 ~ia64 ~ppc64"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/pcimodules-${P}.diff
	epatch ${FILESDIR}/${PV}-sysfs.patch #38645
	epatch ${FILESDIR}/pciutils-2.1.11-fix-pci-ids-location-refs.patch #62786

	# Unconditionally use -fPIC for libs (#55238)
	sed -i \
		-e "/^include/s/$/\nCFLAGS+=-fPIC/" lib/Makefile \
		|| die "sed lib/Makefile failed"

	sed -i \
		-e "s:-O2:${CFLAGS}:" Makefile \
		|| die "sed Makefile failed"

	# fix command line overflow which did not allow for null terminator
	# when using  lspci -vvv (AGPx1 and AGPx2 and AGPx4) bug #41422
	sed -i -e s/'rate\[8\]'/'rate\[9\]'/g lspci.c \
		|| die "sed failed on lspci.c"

	ebegin "Updating pci.ids"
	if ! ./update-pciids.sh &> /dev/null ; then
		# if we cant update, use a cached version
		mv ${WORKDIR}/pci.ids-${STAMP} ${S}/pci.ids
	fi
	eend 0
}

src_compile() {
	cd ${S}/lib
	./configure
	sed -i \
		-e "s:/usr/share/pci.ids:/usr/share/misc/pci.ids:" config.h \
		|| die "sed config.h failed"

	cd ${S}
	emake PREFIX=/usr lib || die "emake lib failed"
	emake PREFIX=/usr || die "emake failed"

	sed -i \
		-e "s:/usr/share/pci.ids:/usr/share/misc/pci.ids:" \
		update-pciids lspci.8 update-pciids.8 \
		|| die "sed failed"
}

src_install() {
	into /
	dosbin setpci lspci pcimodules update-pciids || die "dosbin failed"
	doman *.8

	insinto /usr/share/misc
	doins pci.ids || die

	into /usr
	dolib lib/libpci.a

	insinto /usr/include/pci
	doins lib/*.h
}
