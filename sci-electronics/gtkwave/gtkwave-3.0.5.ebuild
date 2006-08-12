# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/gtkwave/gtkwave-3.0.5.ebuild,v 1.2 2006/08/12 14:24:51 plasmaroo Exp $

inherit eutils

DESCRIPTION="A wave viewer for LXT, LXT2, VZT, GHW and standard Verilog VCD/EVCD files"
HOMEPAGE="http://home.nc.rr.com/gtkwave/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

IUSE="doc examples"
LICENSE="GPL-2 MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

DEPEND=">=x11-libs/gtk+-2"

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
	econf || die 'econf failed!'

	# Bug #142871
	emake -j1 || die 'emake failed!'
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc ANALOG_README.TXT CHANGELOG.TXT
	if use doc ; then
		dohtml doc/LXT_Explained.html
		insinto /usr/share/doc/${PF}
		doins doc/gtkwave.pdf
	fi
	if use examples ; then
		insinto /usr/share/${PF}
		doins -r examples
	fi
}
