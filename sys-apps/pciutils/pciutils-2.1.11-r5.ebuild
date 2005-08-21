# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pciutils/pciutils-2.1.11-r5.ebuild,v 1.2 2005/08/21 18:27:15 vapier Exp $

inherit eutils flag-o-matic toolchain-funcs

STAMP=20041019
DESCRIPTION="Various utilities dealing with the PCI bus"
HOMEPAGE="http://atrey.karlin.mff.cuni.cz/~mj/pciutils.html"
SRC_URI="ftp://atrey.karlin.mff.cuni.cz/pub/linux/pci/${P}.tar.gz
	mirror://gentoo/pci.ids-${STAMP}.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ia64 m68k ~mips ~ppc ~ppc64 s390 sh ~sparc x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch ${FILESDIR}/pcimodules-${P}.diff
	epatch ${FILESDIR}/${P}-sysfs.patch #38645
	epatch ${FILESDIR}/${P}-gentoo-paths.patch
	epatch ${FILESDIR}/${PV}-scan.patch #from fedora

	# Unconditionally use -fPIC for libs (#55238)
	# Make sure we respect $AR / $RANLIB / $CFLAGS
	sed -i \
		-e "/^include/s/$/\nCFLAGS+=-fPIC/" \
		-e '/ar rcs/s:ar:$(AR):' \
		-e 's:ranlib:$(RANLIB):' \
		lib/Makefile \
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
	tc-export AR CC RANLIB
	# we run the lib target ourselves to work around broken 
	# dependency tracking inside of the makefile
	emake lib || die "emake lib failed"
	emake PREFIX=/usr SHAREDIR=/usr/share/misc || die "emake failed"
}

src_install() {
	into /
	dosbin setpci lspci pcimodules update-pciids || die "dosbin failed"
	doman *.8

	insinto /usr/share/misc
	doins pci.ids || die "pciids failed"

	into /usr
	dolib lib/libpci.a || die "libpci failed"

	insinto /usr/include/pci
	doins lib/*.h || die "headers failed"
}
