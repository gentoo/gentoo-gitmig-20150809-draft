# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/gtkwave/gtkwave-3.0.23.ebuild,v 1.1 2007/04/01 15:17:14 calchan Exp $

DESCRIPTION="A wave viewer for LXT, LXT2, VZT, GHW and standard Verilog VCD/EVCD files"
HOMEPAGE="http://home.nc.rr.com/gtkwave/"
SRC_URI="http://home.nc.rr.com/gtkwave/${P}.tar.gz
	doc? ( http://home.nc.rr.com/gtkwave/${PN}-doc-${PV}.tar.gz )"

IUSE="doc examples"
LICENSE="GPL-2 MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

DEPEND=">=x11-libs/gtk+-2
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Using sed below, because equivalent patch is much bigger

	# configure must not be interactive, force GTK2
	sed -i \
		-e 's:echo "Build GTKWave for GTK+-1.x or 2.x?:# Build for GTK2:' \
		-e 's:read X:X="2":' \
		configure \
		|| die "sed failed"

	# Fix command substitution
	sed -i \
		-e 's:`pkg-config gtk+-2.0 --libs`:$(shell pkg-config gtk+-2.0 --libs):' \
		-e 's:`pkg-config gtk+-2.0 --cflags`:$(shell pkg-config gtk+-2.0 --cflags):' \
		src/Makefile_GTK2.in \
		contrib/rtlbrowse/Makefile_GTK2.in \
		|| die "sed failed"

	# Comply with DESTDIR
	sed -i \
		-e 's:$(bindir):$(DESTDIR)/$(bindir):' \
		-e 's:$(mandir):$(DESTDIR)/$(mandir):' \
		Makefile.in \
		|| die "sed failed"

	# CFLAGS fixes
	sed -i \
		-e 's:CFLAGS = -O2:CFLAGS +=:' \
		src/Makefile_GTK2.in \
		*/*/Makefile*.in \
		|| die "sed failed"
	sed -i \
		-e 's:=$(COPT): +=:' \
		contrib/pccts/*/*/Makefile.in \
		|| die "sed failed"
	sed -i \
		-e 's:= $(COPT):+=:' \
		contrib/pccts/*/Makefile.in \
		|| die "sed failed"

	# LDFLAGS fixes
	sed -i \
		-e 's:$(CFLAGS) $(OBJS):$(CFLAGS) $(LDFLAGS) $(OBJS):' \
		src/Makefile_GTK2.in \
		|| die "sed failed"
	sed -i \
		-e 's:LDFLAGS=:LDFLAGS+=:' \
		contrib/rtlbrowse/Makefile_GTK2.in \
		|| die "sed failed"
	sed -i \
		-e 's:$(CC) $(CFLAGS) -o:$(CC) $(CFLAGS) $(LDFLAGS) -o:' \
		contrib/pccts/*/Makefile.in \
		src/helpers/Makefile.in \
		|| die "sed failed"
	sed -i \
		-e 's:$(CC) -o:$(CC) $(LDFLAGS) -o:' \
		contrib/vertex/Makefile.in \
		contrib/pccts/sorcerer/Makefile.in \
		contrib/pccts/support/genmk/Makefile.in \
		|| die "sed failed"
	sed -i \
		-e 's:-o ghwdump:$(LDFLAGS) -o ghwdump:' \
		src/helpers/Makefile.in \
		|| die "sed failed"
}

src_compile() {
	econf || die 'Configuration failed'

	# Bug #142871
	emake -j1 || die 'Compilation failed'
}

src_install() {
	emake DESTDIR=${D} install || die "Installation failed"
	dodoc ANALOG_README.TXT CHANGELOG.TXT
	if use doc ; then
		insinto /usr/share/doc/${PF}
		doins "${WORKDIR}/${PN}.pdf" || die "Failed to install documentation."
	fi
	if use examples ; then
		insinto /usr/share/doc/${PF}
		doins -r examples || die "Failed to install examples."
	fi
}
