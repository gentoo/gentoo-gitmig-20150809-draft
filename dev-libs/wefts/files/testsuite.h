/*
   testsuite.h
   Definition of test class.

   $Id: testsuite.h,v 1.1 2005/05/28 12:34:30 flameeyes Exp $
---------------------------------------------
   Begin      : Fri, 12 Mar 2004 07:53:14 +0100
   Author     : Giancarlo Niccolai

   Last modified because:

*/

/**************************************************************************
*   This program is free software; you can redistribute it and/or modify  *
*   it under the terms of the GNU Library General Public License as       *
*   published by the Free Software Foundation; either version 2.1 of the  *
*   License, or (at your option) any later version.                       *
***************************************************************************/

#ifndef TESTSUITE_H
#define TESTSUITE_H

#include <vector>
#include <string>

/** Forward declaration */
class Test;
class TestSuite;

/** Construct on first use semantic! */
TestSuite& defTestSuite();

class TestProgress
{
public:
   virtual void progress( int max, int cur ) = 0;
   virtual int verbosity() const = 0;
   virtual int stressLevel() const = 0; 
};

typedef std::vector< Test *> TestList;

class TestSuite: public TestProgress
{
   TestList m_tests;
   Test *m_current;
   int m_currentId;
   
   int m_verbosity;
   int m_stressLevel;
public:
   TestSuite() {
      m_verbosity = 0;
      m_stressLevel = 0;
   };
   
   void add( Test *test );

   virtual void progress( int max, int cur );
   virtual int verbosity() const { return m_verbosity; }
   virtual int stressLevel() const { return m_stressLevel; }
   void verbosity(const int lev ) { m_verbosity = lev; }
   void stressLevel( const int lev ) { m_stressLevel = lev; }

   
   int countTests() { return m_tests.size(); }
   
   void run();
   void list();
   void sort();
   void listTest( int id );
   void runTest( int id );
};

/** A test instance. */
class Test: public TestProgress
{
protected:
   bool m_result;
   bool m_complete;
   TestProgress *m_progressor;
   
   std::string m_name;
   std::string m_description;
   
protected:
   int m_testId;
   
   Test( TestSuite* target = 0 ) { 
      m_result = false;
      m_complete = false;
      m_progressor = this ;
      
      // provide a coherent default
      // testId is starting from 1.
      m_testId = 1;
      
      if (target) 
         target->add( this );
      else 
         defTestSuite().add( this );
   }

public:

   bool complete() { return m_complete; }
   bool result() { return m_result; }
   void setProgressor( TestProgress *prog ) { m_progressor = prog; }
   /** We set a dummy progressor to ourselves to "do nothing" if no progressor is set. 
      This method does nothing; when initialized, the test class progressor is set
      to itself, so if the test sends some progress but no correct progressor has
      been set, this dummy test gets called.
   */
   virtual void progress( int , int ) {}
   virtual int verbosity() const {return 0;}
   virtual int stressLevel() const {return 0;} 
   /** ID of this test.
      It starts from 1...!
   */
   int testId() const { return m_testId; }
   
   const std::string &name() const { return m_name; }
   const std::string &description() const { return m_description ; }
   virtual bool run() = 0;
   
};


#endif
/* end of testsuite.h */
