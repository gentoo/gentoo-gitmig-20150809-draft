# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-SpamAssassin/Mail-SpamAssassin-2.61.ebuild,v 1.1 2003/12/18 19:45:00 rac Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Perl Mail::SpamAssassin - A program to filter spam"
SRC_URI="http://spamassassin.org/released/${P}.tar.bz2"
HOMEPAGE="http://spamassassin.org"
IUSE="berkdb ssl"
SLOT="0"
LICENSE="GPL-2 | Artistic"
KEYWORDS="~x86 amd64 ~ppc ~sparc ~alpha"

newdepend ">=dev-perl/ExtUtils-MakeMaker-6.11-r1
	dev-perl/Time-Local
	dev-perl/Getopt-Long
	>=dev-perl/File-Spec-0.8
	>=dev-perl/PodParser-1.22
	>=dev-perl/HTML-Parser-3.24
	dev-perl/Net-DNS
	dev-perl/Digest-SHA1
	ssl?    ( dev-perl/IO-Socket-SSL )
	berkdb? ( dev-perl/DB_File )"

myconf="CONTACT_ADDRESS=root@localhost RUN_RAZOR_TESTS=0"

# If ssl is enabled, spamc can be built with ssl support
if use ssl; then
	myconf="${myconf} ENABLE_SSL=yes"
fi

# if you are going to enable taint mode, make sure that the bug where
# spamd doesn't start when the PATH contains . is addressed, and make
# sure you deal with versions of razor <2.36-r1 not being taint-safe.
# <http://bugzilla.spamassassin.org/show_bug.cgi?id=2511> and
# <http://spamassassin.org/released/Razor2.patch>.

myconf="${myconf} PERL_TAINT=no"

# No settings needed for 'make all'.
mymake=""

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
	sample-spam.txt "

src_compile() {
	perl-module_src_compile
	perl-module_src_test
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
}

pkg_postinst() {
	perl-module_pkg_postinst

	if [ -z "`best_version dev-perl/DB_File`" ]; then
		einfo "The Bayes backend requires the Berkeley DB to store its data. You"
		einfo "need to emerge dev-perl/DB_File to make it available."
	fi

}
