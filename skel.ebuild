# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# NOTE: The comments in this file are for instruction and documentation.
# They're not meant to appear with your final, production ebuild.  Please
# remember to remove them before submitting or committing your ebuild.  That
# doesn't mean you can't add your own comments though.

# The 'Header' on the third line should just be left alone.  When your ebuild
# will be commited to cvs, the details on that line will be automatically
# generated to contain the correct data.

# Short one-line description of this package.
DESCRIPTION="This is a sample skeleton ebuild file"

# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="http://"

# License of the package. This must match the name of file(s) in
# /usr/portage/licenses/. For complex license combination see the developer
# docs on gentoo.org for details.
LICENSE=""

# Build-time dependencies, such as
#    ssl? ( >=openssl-0.9.6b )
#    >=perl-5.6.1-r1
# It is advisable to use the >= syntax show above, to reflect what you
# had installed on your system when you tested the package.  Then
# other users hopefully won't be caught without the right version of
# a dependency.
DEPEND=""

# Run-time dependencies, same as DEPEND if RDEPEND isn't defined:
#RDEPEND=""

# Point to any required sources; these will be automatically downloaded by
# Portage.
SRC_URI="ftp://foo.bar.com/${P}.tar.gz"

# Source directory; the dir where the sources can be found (automatically
# unpacked) inside ${WORKDIR}.  S will get a default setting of ${WORKDIR}/${P}
# if you omit this line.

S=${WORKDIR}/${P}

src_compile() {
	# Most open-source packages use GNU autoconf for configuration.
	# You should use something similar to the following lines to
	# configure your package before compilation.  The "|| die" portion
	# at the end will stop the build process if the command fails.
	# You should use this at the end of critical commands in the build
	# process.  (Hint: Most commands are critical, that is, the build
	# process should abort if they aren't successful.)
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	# Note the use of --infodir and --mandir, above. This is to make
	# this package FHS 2.2-compliant.  For more information, see
	#   http://www.pathname.com/fhs/
	
	# emake (previously known as pmake) is a script that calls the
	# standard GNU make with parallel building options for speedier
	# builds (especially on SMP systems).  Try emake first.  It might
	# not work for some packages, in which case you'll have to resort
	# to normal "make".
	emake || die
	#make || die
}

src_install () {
	# You must *personally verify* that this trick doesn't install
	# anything outside of DESTDIR; do this by reading and
	# understanding the install part of the Makefiles. 
	make DESTDIR=${D} install || die
	# For Makefiles that don't make proper use of DESTDIR, setting
	# prefix is often an alternative.  However if you do this, then
	# you also need to specify mandir and infodir, since they were
	# passed to ./configure as absolute paths (overriding the prefix
	# setting).
	#make \
	#	prefix=${D}/usr \
	#	mandir=${D}/usr/share/man \
	#	infodir=${D}/usr/share/info \
	#	install || die
	# Again, verify the Makefiles!  We don't want anything falling
	# outside of ${D}.
}
