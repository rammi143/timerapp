package com.timer;



import java.io.Serializable;

import com.google.appengine.api.blobstore.BlobKey;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;

@Entity
public class Contact implements Serializable {

	private static final long serialVersionUID = 1L;

   @Id
   private Long id;

   private String name;
   @Index
   private String email;
   @Index
   private String password;

   private String mobileNumber;
   private String address;
   @Index
   private Boolean active;
   
   private String profileurl;
   
   @Index
   private String resetString;
   
   public Contact() {} 
   
   public Contact(String password)
   {
	   this.password=password;
   }
   
   public Contact(String name,String mobileNumber,String address)
     {
	   this.name = name;
       this.mobileNumber = mobileNumber;
       this.address=address;
       
     }
   
	public Contact(String name, String email,  String mobileNumber,String address,String password) {
       this.name = name;
       this.email = email;
       this.mobileNumber = mobileNumber;
       this.address=address;
       this.password = password;
       this.profileurl=null;
       this.resetString=null;
       this.active=true;
     }
	 public Long getId() {
			return id;
		}
    public String getResetString() {
		return resetString;
	}
	public void setResetString(String resetString) {
		this.resetString = resetString;
	}
	public void setProfileurl(String profileurl)
    {
    	this.profileurl=profileurl;
    }
    public String getProfileurl()
    {
      return this.profileurl;
    }
    
    public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public void setActive(Boolean active) {
       this.active = active;
     }
    public Boolean getActive() {
       return active;
      }
    public String getName() {
       return name;
      }
    public void setName(String name) {
       this.name = name;
      }
    public String getEmail() {
       return email;
      }
     public void setEmail(String email) {
        this.email = email;
      }
     public String getPassword() {
        return password;
      }
     public void setPassword(String password) {
        this.password = password;
     }
     public String getmobileNumber() {
        return mobileNumber;
     }
     public void setmobileNumber(String mobileNumber) {
        this.mobileNumber = mobileNumber;
      }


}