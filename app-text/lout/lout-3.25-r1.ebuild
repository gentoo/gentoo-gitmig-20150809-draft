# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author: Christian V. J. Brüssow <cvjb@epost.de>
# $Header: /var/cvsroot/gentoo-x86/app-text/lout/lout-3.25-r1.ebuild,v 1.2 2002/08/16 02:42:01 murphy Exp $

# Short one-line description of this package.
DESCRIPTION="Lout is a high-level language for document formatting."

# Valeriy Ushakovs offical Lout Homepage.
HOMEPAGE="http://snark.ptc.spbu.ru/~uwe/lout/"

# License of the package. This must match the name of file(s) in
# /usr/portage/licenses/. For complex license combination see the developer
# docs on gentoo.org for details.
LICENSE="GPL-2"

# QA issues - added by phoen][x <phoenix@gentoo.org>
KEYWORDS="x86 sparc sparc64"
SLOT="0"

# Build-time dependencies, such as
#    ssl? ( >=openssl-0.9.6b )
#    >=perl-5.6.1-r1
DEPEND=">=zlib-1.1.4"

# Run-time dependencies, same as DEPEND if RDEPEND isn't defined:
RDEPEND=""

# Jeff Kingstons original site (veeery slow): ftp://ftp.cs.esyd.edu.au/jeff/.
SRC_URI="http://www.tex.ac.uk/tex-archive/support/lout/${P}.tar.gz"

src_unpack() {
	unpack $A
	cd ${S}

	# Apply the makefile patch, this is the only configuration so far :-(
	patch -p0 < ${FILESDIR}/${P}-r1-makefile-gentoo.patch
}

src_compile() {
	# Lout does not have autoconf/configure support :-(
	# so everything we can do for now is the patch in src_unpack.
	
	# emake (previously known as pmake) is a script that calls the
	# standard GNU make with parallel building options for speedier
	# builds (especially on SMP systems).  Try emake first.  It might
	# not work for some packages, in which case you'll have to resort
	# to normal "make".
	emake prg2lout lout || die "emake prg2lout lout failed"
}

src_install() {
	# You must *personally verify* that this trick doesn't install
	# anything outside of DESTDIR; do this by reading and
	# understanding the install part of the Makefiles. 
	emake DESTDIR=${D} install installdoc installman || die "emake install failed"
	# Again, verify the Makefiles!  We don't want anything falling
	# outside of ${D}.

	dodoc README READMEPDF blurb blurb.short whatsnew
}

pkg_postinst() {
	# Initializing run (should be silent, no errors expected)
	/usr/bin/lout -x -s /usr/lib/lout/include/init
	# Changing mod of files just created by initializing run
	chmod 644 /usr/lib/lout/data/*
	chmod 644 /usr/lib/lout/hyph/*
}

# vim:ts=4:sw=4:noexpandtab:
