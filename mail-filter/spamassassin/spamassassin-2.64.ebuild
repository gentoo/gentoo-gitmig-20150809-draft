# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/spamassassin/spamassassin-2.64.ebuild,v 1.9 2004/10/26 23:39:42 mcummings Exp $

inherit perl-module

MY_P=Mail-SpamAssassin-${PV}

S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl Mail::SpamAssassin - A program to filter spam"
HOMEPAGE="http://spamassassin.org/"
SRC_URI="http://old.spamassassin.org/released/${MY_P}.tar.bz2"

LICENSE="|| ( GPL-2  Artistic )"
SLOT="0"
KEYWORDS="x86 ppc sparc ~mips alpha hppa amd64 ia64 ppc64"
IUSE="berkdb ssl"

DEPEND="|| ( >=dev-lang/perl-5.8.2-r1
	( >=dev-perl/ExtUtils-MakeMaker-6.11-r1
	>=dev-perl/File-Spec-0.8
	dev-perl/Time-Local
	dev-perl/Getopt-Long
	) )
	>=dev-perl/PodParser-1.22
	>=dev-perl/HTML-Parser-3.24
	dev-perl/Net-DNS
	dev-perl/Digest-SHA1
	ssl?    ( dev-perl/IO-Socket-SSL )
	berkdb? ( dev-perl/DB_File )"

# Neither for 'make install'.
myinst=""

# Some more files to be installed (README* and Changes are already
# included per default)
mydoc="License
	COPYRIGHT
	TRADEMARK
	CONTRIB_CERT
	BUGS
	USAGE
	procmailrc.example
	sample-nonspam.txt
	sample-spam.txt
	qmail/README.qmail-spamc"

src_compile() {
	# If ssl is enabled, spamc can be built with ssl support
	use ssl && myconf="${myconf} ENABLE_SSL=yes"

	# if you are going to enable taint mode, make sure that the bug where
	# spamd doesn't start when the PATH contains . is addressed, and make
	# sure you deal with versions of razor <2.36-r1 not being taint-safe.
	# <http://bugzilla.spamassassin.org/show_bug.cgi?id=2511> and
	# <http://spamassassin.org/released/Razor2.patch>.
	myconf="${myconf} PERL_TAINT=no"

	# No settings needed for 'make all'.
	mymake=""

	export PERL_MM_USE_DEFAULT=1
	perl-module_src_compile

	# without this check, portage .51 runs test suite twice for people
	# with the maketest feature

	if ! hasq maketest $FEATURES; then
		perl-module_src_test
	fi
	cd ${S}
	make qmail/qmail-spamc
}

src_install () {
	perl-module_src_install

	# Add the init and config scripts.
	dodir /etc/init.d /etc/conf.d
	insinto /etc/init.d
	newins ${FILESDIR}/spamd.init spamd
	fperms 755 /etc/init.d/spamd
	insinto /etc/conf.d
	newins ${FILESDIR}/spamd.conf spamd

	into /usr
	dobin qmail/qmail-spamc
}

pkg_postinst() {
	perl-module_pkg_postinst

	if [ -z "`best_version dev-perl/DB_File`" ]; then
		einfo "The Bayes backend requires the Berkeley DB to store its data. You"
		einfo "need to emerge dev-perl/DB_File to make it available."
	fi

}
